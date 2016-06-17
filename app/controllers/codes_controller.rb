class CodesController < ApplicationController

  layout 'shared/home'

  before_action :load_codes, only: [:index, :show, :edit, :update, :destroy]

  def index
    @codes = @codes.page(params[:page]).per(15).includes(:user, :category, :language)
  end

  def show
    @code = @codes.find(params[:id])
  end

  def new
    @code = Code.new
  end

  # def index
  #   @codes = @blogger.codes.page(params[:page_code]).per(15)
  #
  # end
  #
  # def show
  #   @code = Code.find(params[:id])
  # end

  def create
    @code = Code.new(code_params)
    @code.user = current_user

    if @code.save
      flash[:notice] = '你已经成功收藏了代码。'
      redirect_to admin_code_path(@code)
    else
      flash[:error] = '收藏代码失败，请注意以下提示！'
      render :new
    end
  end

  def edit
    @code = @codes.find(params[:id])
  end

  def update
    @code = @codes.find(params[:id])

    if @code.update_attributes(code_params)
      flash[:notice] = '你已经成功更新了收藏的代码。'
      redirect_to action: :show
    else
      flash[:error] = '修改代码失败，请注意以下提示！'
      render :edit
    end
  end

  def destroy
    @code = @codes.find(params[:id])
    @code.destroy

    flash[:notice] = '你已经成功删除了该代码。'
    redirect_to admin_codes_path
  end

  private
  def load_codes
    @codes ||= (Code.all.order('updated_at desc') || current_user.codes) #TODO
  end

  def code_params
    params.require(:code).permit(:user_id, :language_id, :category_id, :source, :title, :content, :tags)
  end
end
