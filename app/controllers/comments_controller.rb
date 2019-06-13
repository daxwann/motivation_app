class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:notices] = ["Comment added!"]
    else
      flash[:errors] = @comment.errors.full_messages
    end

    redirect_back fallback_location: users_url
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    if comment.author_id == current_user.id
      comment.destroy
      flash[:notices] = ["Comment deleted!"]
    else
      flash[:errors] = ["User not authorized to delete comment"]
    end

    redirect_back fallback_location: users_url
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
