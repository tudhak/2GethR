class TasksController < ApplicationController
  before_action :set_couple, only: [:index]
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :set_partner, only: [:index, :show]

  def index
    @tasks = Task.where(user: User.where(couple_id: @couple.id))
    @my_pending_tasks = Task.where(assigned_to: current_user.nickname).where(status: "pending").order(date: :desc)
    @task = Task.new

    if params[:my_params].present?
      # raise
      @tasks = Task.where(assigned_to: params[:my_params][:assigned_to], status: params[:my_params][:status])
    end

    respond_to do |format|
      format.html
      format.text { render partial: "tasks/content", locals: { tasks: @tasks }, formats: [:html] }
    end
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save!
      redirect_to task_path(@task)
    else
      render partial: "tasks/add_task_modal", status: :unprocessable_entity
    end

    if params[:other_params].present?
      # raise
      @description = GenericTask.where(title: params[:other_params][:title]).description
    end

    # respond_to do |format|
    #   format.html { redirect_to tasks_path }
    #   format.text { render partial: "tasks/add_task_modal", locals: { description: @description }, formats: [:html] }
    # end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render "tasks/edit_task_modal", status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end

  def mark_as_done
    @task = Task.find(params[:id])
    # raise
    @task.update(status: "done")
    current_user.score += @task.base_score unless @task.base_score.nil?
    current_user.save!
    redirect_to task_path(@task), notice: "Status updated to #{@task.status}"
  end

  private

  def set_couple
    @couple = current_user.couple
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_partner
    @partner = User.where(couple_id: current_user.couple_id).where.not(id: current_user.id).first
  end

  def task_params
    params.require(:task).permit(:title, :description, :date, :base_score, :status, :assigned_to, photos: [])
  end
end
