class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])

    if @goal && current_user.id == @goal.user_id 
      render :show
    else
      redirect_to user_url(current_user)
    end
  end

  def edit
    @goal = Goal.find_by(id: params[:id])

    if @goal && current_user.id == @goal.user_id
      render :edit
    else
      redirect_to user_url(current_user)
    end
  end

  def update
  end

  def destroy
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :detail, :public)
  end
end
