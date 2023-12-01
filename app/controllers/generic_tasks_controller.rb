class GenericTasksController < ApplicationController
  def index
    @generic_tasks = GenericTask.where(couple: current_user.couple)
  end
end
