class GoalsController < ApplicationController
  before_action :require_login!

  def index
    @goals = current_user.goals
    render :index
  end

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

    if @goal && (@goal.public == true || current_user.id == @goal.user_id) 
      render :show
    else
      flash[:errors] = ["You don't have permission to see this goal"]
      redirect_to user_url(current_user)
    end
  end

  def edit
    @goal = Goal.find_by(id: params[:id])

    if @goal && current_user.id == @goal.user_id
      render :edit
    else
      flash[:errors] = ["You don't have permission to edit this goal"]
      redirect_to user_url(current_user)
    end
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    
    unless @goal.user_id == current_user.id
      redirect_to goals_url 
    end

    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])

    if @goal.user_id == current_user.id
      @goal.destroy!
    end

    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :detail, :public, :completed)
  end
end
