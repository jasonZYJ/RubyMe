class HomeController < ApplicationController
  include ApplicationHelper

  layout 'shared/home'
  before_action :keep_redirect_url

  def index
    @codes = Code.page(params[:page]).includes(:user)
    @posts = Post.order("likes_count desc, created_at desc").page(params[:page]).per(10).includes(:user, :category, :last_reply_user)
  end

  def about_us
  end

  protected

  def keep_redirect_url
    session[:redirect_url] = url_for
  end

end
