class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :check_browser
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :load_messages, if: Proc.new { current_user.present? && !controller_path.start_with?("system") }

  def title
    site_info
  end

  protected

  def load_messages
    @messages ||= current_user.messages
  end

  def check_browser
    # notice if browser lt IE9
    if browser.ie? && browser.version.to_i < 9
      unless cookies[:is_noticed_browser]
        cookies[:is_noticed_browser] = {value: true, expires: 1.hour.from_now}
        flash[:alert] = "你使用的浏览器太老了，博客眼的很多Html5特性不支持，赶快升级吧！"
      end
    end
  end

  def require_user
    if current_user.blank?
      respond_to do |format|
        format.html { authenticate_user! }
        format.all { head(:unauthorized) }
      end
    end
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

  #  # for user devise session
  def after_sign_up_path_for(resource_or_scope)
    session[:redirect_url] || super
  end

end
