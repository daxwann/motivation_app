class UserCommentsController < ApplicationController
  def create
    @comment = UserComment.new(user_comment_params)
    @comment.author_id = current_user.id
    
    if @comment.save
      redirect_to user_url(@comment.user_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      @user = User.find_by(id: params[:user_comment][:user_id])
      render 'users/show'
    end
  end

  def destroy
    comment = UserComment.find_by(id: params[:id])
    if comment.author_id == current_user.id
      user_id = comment.user_id
      comment.destroy
      redirect_to user_url(user_id)
    else
      render plain: "Unauthorized User", status: 403
    end
  end

  private

  def user_comment_params
    params.require(:user_comment).params(:body, :user_id)
  end
end
