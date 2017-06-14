# encoding: utf-8
class UsersController < BloggerController

  # layout 'shared/home'

  # after_action :load_categories#:update_visits, only: [:show]

  # before_action :load_user TODO NECESSARY HERE?

  def show
    @posts = @posts.page(params[:page]).per(8)
  end

  def profile
    @user ||= resource_class.find_by_uid(params[:id])
  end

  def calendar
    render json: @blogger.calendar_data
  end

  def home
    @posts = @user.posts
    @replies = Reply.where(post_id: @posts.pluck(:id))

    @posts = @posts.page(params[:page]).includes(:category, :replies)
    @replies = @replies.page(params[:page_reply]).includes(:post, :user)

  end

  def update_profile
    if @user.update_attributes(user_params)
      flash[:notice] = I18n.t('activerecord.message.user.update_successful')
      redirect_to admin_profile_path
    else
      flash[:error] = I18n.t('activerecord.message.user.update_failed')
      render :profile
    end
  end

  protected
  # override super method
  def load_blogger
    @blogger = resource_class.find_by_uid(params[:id])
  end

  def load_user
    @user = current_user
  end


  # def load_categories
  #   @categories ||= current_user.categories
  # end

  # def update_visits
  #   if @blogger != current_user
  #     @blogger.update_attributes(visits: @blogger.visits + 1)
  #   end
  # end

  def user_params
    params.require(:user).permit(:avatar, :name, :is_email_public, :signature, :city_name, :company, :github, :homepage, :description)
  end
end
