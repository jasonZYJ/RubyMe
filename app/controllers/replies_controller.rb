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

    flash[:notice] = '你已经成功删除了该评论。'
    js_reload_without_params
  end

  def hide
    @reply = @replies.find(params[:id])
    @reply.destroy

    flash[:notice] = '你已经成功隐藏了该评论。'
    js_reload_without_params
  end

  def restore
    @reply = @replies.find(params[:id])
    @reply.restore

    flash[:notice] = '你已经成功恢复了该评论。'
    js_reload_without_params
  end



  def create #TODO Frontend
    @reply = Reply.new(reply_params)
    @reply.user = current_user
    @reply.post = @post

    if @reply.save
      flash[:notice] = '你已经成功提交了回复。'
      redirect_to "#{post_path(@post)}#reply#{@reply.id}"
    else
      add_error_to_flash
      redirect_to post_path(@post)
    end
  end
  #
  # protected
  # # override super method

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


  protected
  def load_replies
    @replies = current_user.replies.with_deleted
  end

  def load_blogger
    post_id = params[:post_id]
    @post = Post.find(post_id)
    @blogger = @post.user
  end
end
