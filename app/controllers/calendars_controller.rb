class CalendarsController < ApplicationController
  def index
    @tasks = Task.where(user: User.where(couple_id: current_user.couple))
    @rewards = Reward.where(user: User.where(couple_id: current_user.couple))

    if params.present?
      @tasks = Task.where(user: User.where(couple_id: current_user.couple), date: params[:date])
      @rewards = Reward.where(user: User.where(couple_id: current_user.couple), date: params[:date])
    end

    respond_to do |format|
      format.html
      format.text { render partial: "calendars/events", locals: { tasks: @tasks, rewards: @rewards }, formats: [:html] }
    end
  end
end
