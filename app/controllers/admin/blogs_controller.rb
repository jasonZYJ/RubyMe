class Admin::BlogsController < AdminController

  before_action :load_blogs, only: [:index, :show, :edit, :update, :destroy]

  def index
    @blogs = @blogs.page(params[:page]).per(15).includes(:category)
  end

  def show
    @blog = @blogs.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user

    if @blog.save
      flash[:notice] = '你已经成功创建了日志。'
      redirect_to admin_blog_path(@blog)
    else
      flash[:error] = '创建日志失败，请注意以下提示！'
      render :new
    end
  end

  def edit
    @blog = @blogs.find(params[:id])
  end

  def update
    @blog = @blogs.find(params[:id])

    if @blog.update_attributes(blog_params)
      flash[:notice] = '你已经成功更新了日志。'
      redirect_to action: :show
    else
      flash[:error] = '更新日志失败，请注意以下提示！'
      render :edit
    end
  end

  def destroy
    @blog = @blogs.find(params[:id])
    @blog.destroy

    flash[:notice] = '你已经成功删除了该代码。'
    redirect_to admin_blogs_path
  end

  private
  def load_blogs
    @blogs = current_user.blogs
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :category_id, :user_id, :status, :created_at)
  end
end
