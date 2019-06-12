class GoalCommentsController < ApplicationController
  def create
    comment = GoalComment.new(goal_comment_params)
    comment.author_id = current_user.id
    redirect_to goal_url(
  end

  def destroy
  end

  private

  def goal_comment_params
    params.require(:goal_comment).params(:body, :goal_id)
  end
end
