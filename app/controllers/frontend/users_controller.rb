# encoding: utf-8
class Frontend::UsersController < BloggerController

  def show
    @posts = @posts.page(params[:page]).per(4)
  end

 protected
  # override super method
  def load_blogger
    @blogger = User.find(params[:id])
  end

end
