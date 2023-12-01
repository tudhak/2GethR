class GenericTasksController < ApplicationController
  before_action :set_generic_task, only: [:update, :destroy]

  def index
    @generic_tasks = GenericTask.where(couple: current_user.couple)
    @generic_task = GenericTask.new
    #test
  end

  def destroy
    @generic_task.destroy
    redirect_to generic_tasks_path, notice: 'Generic task was successfully destroyed.'
  end

  def create
    @generic_task = GenericTask.new(generic_task_params)
    @generic_task.couple = current_user.couple
    if @generic_task.save!
      redirect_to generic_task_path(@generic_task)
    else
      render partial: "generic_tasks/add_generic_task_modal", status: :unprocessable_entity
    end
  end

  def update
    if @generic_task.update!(generic_task_params)
      redirect_to @generic_tasks, notice: 'Generic Task was successfully updated.'
    else
      render "generic_tasks/edit_generic_task", status: :unprocessable_entity
    end
  end

  private

  def set_generic_task
    @generic_task = GenericTask.find(params[:id])
  end

  def generic_task_params
    params.require(:generic_task).permit(:title, :description, :base_score, photos: [])
  end
end
