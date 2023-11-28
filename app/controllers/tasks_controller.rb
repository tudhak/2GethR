class TasksController < ApplicationController
  def index
    @task_bookings = Task.all
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
