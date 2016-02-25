class Frontend::HomeController < FrontendController

  # caches_action :index, cache_path: proc { |c| c.params }, expires_in: 1.minute
  def index
    @codes = Code.limit(12).includes(:user)
    @posts = Post.order("likes desc, created_at desc").limit(12).includes(:user, :category, :last_reply_user)
  end

  def about_us
  end

end
