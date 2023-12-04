class CalendarsController < ApplicationController
  def index
    @tasks = Task.where(user: User.where(couple_id: current_user.couple))
  end
end
