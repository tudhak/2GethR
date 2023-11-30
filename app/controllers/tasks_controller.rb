class TasksController < ApplicationController
  before_action :set_couple, only: [:index]

  def index
    @tasks = Task.where(user: User.where(couple_id: @couple.id))
    @my_pending_tasks = Task.where(assigned_to: current_user.nickname).where(status: "pending").order(date: :desc)
    @partner = User.where(couple_id: current_user.couple_id).where.not(id: current_user.id).first
    @task = Task.new

    if params[:my_params].present?
      @tasks = Task.where(assigned_to: params[:my_params][:assigned_to], status: params[:my_params][:status])
    end

    respond_to do |format|
      format.html
      format.text { render partial: "tasks/content", locals: { tasks: @tasks }, formats: [:html] }
    end

    # if params[:other_params].present?
    #   @description = GenericTask.find(title: params[:other_params][:title]).description
    # end
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save!
      redirect_to task_path(@task)
    else
      render "tasks/add_task_modal", status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_couple
    @couple = current_user.couple
  end

  def task_params
    params.require(:task).permit(:title, :description, :photos, :date, :base_score, :status, :assigned_to)
  end
end
