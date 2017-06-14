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
    @code = resource_class.new
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
    @code = resource_class.new(code_params)
    @code.user = current_user

    if @code.save
      flash[:notice] = t('activerecord.message.code.create_successful')
      redirect_to admin_code_path(@code)
    else
      flash[:error] = t('activerecord.message.code.create_failed')
      render :new
    end
  end

  def edit
    @code = @codes.find(params[:id])
  end

  def update
    @code = @codes.find(params[:id])

    if @code.update_attributes(code_params)
      flash[:notice] = t('activerecord.message.code.update_successful')
      redirect_to action: :show
    else
      flash[:error] = t('activerecord.message.code.update_failed')
      render :edit
    end
  end

  def destroy
    @code = @codes.find(params[:id])
    @code.destroy

    flash[:notice] = t('activerecord.message.code.delete_successful')
    redirect_to admin_codes_path
  end

  private
  def load_codes
    @codes ||= (resource_class.all.order('updated_at desc') || current_user.codes) #TODO
  end

  def code_params
    params.require(:code).permit(:user_id, :language_id, :category_id, :source, :title, :content, :tags)
  end
end
