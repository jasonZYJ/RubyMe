# encoding: utf-8
class UsersController < BloggerController

  # layout 'shared/home'

   # after_action :load_categories#:update_visits, only: [:show]

  def show
    @posts = @posts.page(params[:page]).per(8)
  end

  def profile
    @user ||= User.find_by_uid(params[:id])
  end

  def calendar
    render json: @blogger.calendar_data
  end

  def home

  end

  protected
  # override super method
  def load_blogger
    @blogger = User.find_by_uid(params[:id])
  end

   # def load_categories
   #   @categories ||= current_user.categories
   # end

  # def update_visits
  #   if @blogger != current_user
  #     @blogger.update_attributes(visits: @blogger.visits + 1)
  #   end
  # end

end
