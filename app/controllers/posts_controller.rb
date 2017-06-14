# encoding: utf-8
class PostsController < ApplicationController

  layout 'shared/home'

  #TODO load_and_authorize_resource, ability
  # need user when execute the following actions
  # before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy,
  #                                           :favorite, :unfavorite, :follow, :unfollow,
  #                                           :action, :favorites]

  before_action :load_posts, only: [:index, :show, :edit, :update, :destroy]
  before_action :load_blogger, only: [:show]

  def index
    @posts = Post.limit(4).page(params[:page]).per(2)
  end

  %w(no_reply popular).each do |name|
    define_method(name) do
      @posts = resource_class.send(name.to_sym).includes(:user)
      @posts = @posts.page(params[:page])

      render action: 'index'
    end
  end

  # GET /posts/favorites
  def favorites
    @posts = resource_class.where(id: current_user.favorite_topic_ids)
    @posts = @posts.recent.page(params[:page])
    render action: 'index'
  end

  def recent
    @posts = resource_class.recent.includes(:user)
    @posts = @posts.page(params[:page])
    render action: 'index'
  end

  def excellent
    @posts = resource_class.excellent.recent.includes(:user)
    @posts = @posts.page(params[:page])

    render action: 'index'
  end

  def new
    @post = resource_class.new
  end

  def show
    @post = @posts.find(params[:id])
    @reply = resource_class.class_for(:replies).new(post_id: @post.id)
    @replies = resource_class.class_for(:replies).includes(:user).where(replies: {post_id: params[:id]})#@post.replies
  end
  #
  # protected
  # # override super method
  def load_blogger
    if params[:user_id].present?
      @blogger = resource_class.class_for(:user).find(params[:user_id])
    else
      @post = resource_class.find(params[:id])
      @blogger = @post.user
    end
  end

  def create
    @post = resource_class.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = t('activerecord.message.post.create_successful')
      redirect_to admin_post_path(@post)
    else
      add_error_to_flash
      render :new
    end
  end

  def edit
    @post = @posts.find(params[:id])
  end

  def update
    @post = @posts.find(params[:id])

    if @post.update_attributes(post_params)
      flash[:notice] = t('activerecord.message.post.update_successful')
      redirect_to action: :show
    else
      add_error_to_flash
      render :edit
    end
  end

  def destroy
    @post = @posts.find(params[:id])
    @post.destroy

    flash[:notice] = t('activerecord.message.post.delete_successful')
    redirect_to admin_root_path
  end

  private
  def load_posts
    @posts ||= (resource_class.all.order('updated_at desc') || current_user.posts) #TODO refine, suck here
  end

  def post_params
    params.require(:post).permit(:user_id, :point_id, :category_id, :source, :title, :content, :tags)
  end

  def add_error_to_flash
    if @post.errors[:base].present?
      flash.now[:error] = @post.errors[:base].first
    else
      flash.now[:error] = draw_errors_message(@post)
    end
  end

end
