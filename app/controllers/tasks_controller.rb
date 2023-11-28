class TasksController < ApplicationController
  before_action :set_couple, only: [:index]

  def index
    @tasks = Task.all
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
    @couple = Couple.find(params[:id])
  end
end
