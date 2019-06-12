class GoalCommentsController < ApplicationController
  def create
    @comment = GoalComment.new(goal_comment_params)
    @comment.author_id = current_user.id
    
    if @comment.save
      redirect_to goal_url(@comment.goal_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      @goal = Goal.find_by(id: params[:goal_comment][:goal_id])
      render 'goals/show'
    end
  end

  def destroy
    comment = GoalComment.find_by(id: params[:id])
    if comment.author_id == current_user.id
      goal_id = comment.goal_id
      comment.destroy
      redirect_to goal_url(goal_id)
    else
      render plain: "Unauthorized User", status: 403
    end
  end

  private

  def goal_comment_params
    params.require(:goal_comment).params(:body, :goal_id)
  end
end
