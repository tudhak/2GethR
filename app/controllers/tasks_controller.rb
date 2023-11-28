class TasksController < ApplicationController
  before_action :set_couple, only: [:index]

  def index
    @tasks = Task.where(user: User.where(couple_id: params[:couple_id]))
    @my_pending_tasks = Task.where(user: current_user).where(statue: "pending").order(date: :desc)
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_couple
    @couple = Couple.find(params[:couple_id])
  end
end
