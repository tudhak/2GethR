class CalendarsController < ApplicationController
  before_action :partner_picture, :user_picture, only: [:index]

  def index
    @tasks = Task.where(user: User.where(couple_id: current_user.couple))
    @rewards = Reward.where(user: User.where(couple_id: current_user.couple))
    @partner = User.where(couple_id: current_user.couple_id).where.not(id: current_user.id).first

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
