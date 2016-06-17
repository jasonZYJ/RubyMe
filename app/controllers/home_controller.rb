class HomeController < ApplicationController
  include ApplicationHelper

  layout 'shared/home'
  before_action :keep_redirect_url

  def index
    @codes = Code.limit(12).includes(:user)
    @posts = Post.order("likes desc, created_at desc").limit(12).includes(:user, :category, :last_reply_user)
  end

  # before_action :load_user
  #
  # #TODO User Home Page
  # # def index
  # #   @posts = @user.posts
  # #   @replies = Reply.where(post_id: @posts.pluck(:id))
  # #
  # #   @posts = @posts.page(params[:page]).includes(:category, :replies)
  # #   @replies = @replies.page(params[:page_reply]).includes(:post, :user)
  # #
  # # end
  #
  def update_profile
    if @user.update_attributes(user_params)
      flash[:notice] = '成功更新个人资料。'
      redirect_to admin_profile_path
    else
      flash[:error] = '未能成功更新个人资料，请查看以下错误。'
      render :profile
    end
  end
  #
  # private
  # def load_user
  #   @user = current_user
  # end
  #
  # def user_params
  #   params.require(:user).permit(:avatar, :name, :is_email_public, :signature, :city_name,
  #                                :company, :github, :homepage, :description)
  # end

  def about_us
  end

  protected

  def keep_redirect_url
    session[:redirect_url] = url_for
  end

  def load_categories
    @categories ||= current_user.categories
  end

  def title
    site_info
  end

end
