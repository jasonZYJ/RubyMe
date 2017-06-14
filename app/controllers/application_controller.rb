class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :check_browser, :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :load_messages, if: Proc.new { current_user.present? && !controller_path.start_with?("system") }

  def title
    site_info
  end

  protected

  def resource_class
     @resource_class ||= controller_path.classify.safe_constantize
  end

  def load_messages
    @messages ||= current_user.messages if current_user
  end

  def check_browser
    # notice if browser lt IE9
    if browser.ie? && browser.version.to_i < 9
      unless cookies[:is_noticed_browser]
        cookies[:is_noticed_browser] = {value: true, expires: 1.hour.from_now}
        flash[:alert] = t('browser_old_message',site_name: Settings.site.name)
      end
    end
  end

  def set_locale
    I18n.locale = user_locale

    # after store current locale
    cookies[:locale] = params[:locale] if params[:locale]
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  def require_user #USAGE need to login
    if current_user.blank?
      respond_to do |format|
        format.html { authenticate_user! }
        format.all { head(:unauthorized) }
      end
    end
  end

  def authenticate_user!(opts = {}) #TODO apply permissions to given action
    return if current_user

    store_location

    super(opts)
  end

  # configure devise permitted parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:uid, :email, :password, :password_confirmation, :remember_me)
    }
    devise_parameter_sanitizer.for(:sign_in) { |u|
      u.permit(:login, :uid, :email, :password, :remember_me)
    }
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:uid, :email, :password, :password_confirmation, :current_password)
    }
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource.class.to_s == "User"
      redirect_url = session[:redirect_url]
      return redirect_url unless redirect_url.blank?
      @messages && @messages.count > 0 ? messages_path : root_path
    else
      super
    end
  end

  # for user devise session
  def after_sign_up_path_for(resource_or_scope)
    session[:redirect_url] || super
  end

  def user_locale
    params[:locale] || cookies[:locale] || http_head_locale || I18n.default_locale
  end

  def http_head_locale
    # detect the users preferred language, as sent by the "Accept-Language" HTTP header
    http_accept_language.language_region_compatible_from(I18n.available_locales)
  end

end
