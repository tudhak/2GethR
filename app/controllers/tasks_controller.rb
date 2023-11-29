class TasksController < ApplicationController
  before_action :set_couple, only: [:index]

  def index
    @tasks = Task.where(user: User.where(couple_id: @couple.id))
    @my_pending_tasks = Task.where(assigned_to: current_user.nickname).where(statue: "pending").order(date: :desc)
    @partner = User.where(couple_id: current_user.couple_id).where.not(id: current_user.id).first
    @task = Task.new

    # raise

    if params[:my_params].present?
      @tasks = Task.where(assigned_to: params[:my_params][:assigned_to], statue: params[:my_params][:statue])
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tasks/content", locals: { tasks: @tasks }, formats: [:html] }
    end
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
    @couple = current_user.couple
  end
end
