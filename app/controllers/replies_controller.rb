class RepliesController < ApplicationController

  before_action :load_replies
  before_action :load_blogger, only: :create

  def index
    @posts = current_user.posts
    @replies = @replies.where(post_id: @posts.pluck(:id))

    @replies = @replies.page(params[:page_reply])
  end

  def destroy
    @reply = @replies.find(params[:id])
    @reply.really_destroy!

    flash[:notice] = t('activerecord.message.reply.delete_successful')
    js_reload_without_params
  end

  def hide
    @reply = @replies.find(params[:id])
    @reply.destroy

    flash[:notice] = t('activerecord.message.reply.hide_successful')
    js_reload_without_params
  end

  def restore
    @reply = @replies.find(params[:id])
    @reply.restore

    flash[:notice] = t('activerecord.message.reply.restore_successful')
    js_reload_without_params
  end

  def create #TODO Frontend
    @reply = Reply.new(reply_params)
    @reply.user = current_user
    @reply.post = @post

    if @reply.save
      flash[:notice] = t('activerecord.message.reply.create_successful')
      redirect_to "#{post_path(@post)}#reply#{@reply.id}"
    else
      add_error_to_flash
      redirect_to post_path(@post)
    end
  end
  # override super method

  protected

  def load_replies
    @replies = current_user.replies.with_deleted
  end

  def load_blogger
    @post = Post.find(params[:post_id])
    @blogger = @post.user
  end

  private

  def reply_params
    params.require(:reply).permit(:user_id, :post_id, :last_reply_id, :content, :is_public)
  end

  def add_error_to_flash
    if @reply.errors[:base].present?
      flash[:error] = @reply.errors[:base].first
    else
      flash[:error] = draw_errors_message(@reply)
    end
  end
end
