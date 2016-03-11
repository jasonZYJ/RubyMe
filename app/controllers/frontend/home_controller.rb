class Frontend::HomeController < FrontendController

  def index
    @codes = Code.limit(12).includes(:user)
    @posts = Post.order("likes desc, created_at desc").limit(12).includes(:user, :category, :last_reply_user)
  end

  def about_us
  end

end
