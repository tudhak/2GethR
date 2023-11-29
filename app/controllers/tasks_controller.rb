class TasksController < ApplicationController
  before_action :set_couple, only: [:index]

  def index
    @tasks = Task.where(user: User.where(couple_id: params[:couple_id]))
    @my_pending_tasks = Task.where(assigned_to: current_user.nickname).where(statue: "pending").order(date: :desc)
    @partner = User.where(couple_id: current_user.couple_id).where.not(id: current_user.id).first
    @filtered_tasks_assigned = @tasks.where(assigned_to: params[:assigned_to])
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
