# encoding: utf-8
class Frontend::UsersController < BloggerController

  def show
    @posts = @posts.page(params[:page]).per(4)
  end

end
