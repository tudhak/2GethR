class RewardsController < ApplicationController
  before_action :set_partner, only: [:index, :to_do_rewards]

  def index
    @generic_rewards = GenericReward.all
    @couple = User.select {|user| user.couple_id == current_user.couple_id }
    @other_person = @couple.select {|user| user != @current_user}.first
  end

  def show
    @reward = Reward.find(params[:id])
  end

  def given_rewards
    @rewards = current_user.rewards
    @pending_rewards = current_user.rewards.where(status: 'pending').order(:date)
    @done_rewards = current_user.rewards.where(status: 'done').order(:date)

    redirect_to couple_rewards_path(current_user.couple)
  end

  def to_do_rewards
    @couple = User.select {|user| user.couple_id == current_user.couple_id }
    @other_person = @couple.select {|user| user != @current_user}.first
    @to_do_rewards = @other_person.rewards
  end

  def mark_as_done
    @reward = Reward.find(params[:id])
    @reward.update(status: 'done')
    redirect_to couple_rewards_path(current_user.couple)
  end


  def new
    @reward = Reward.new
  end

  def create
    @reward = current_user.rewards.build(reward_params)
    if @reward.cost <= current_user.score
      current_user.score -= @reward.cost
      @reward.status = "pending"

      if @reward.save
        current_user.save
        redirect_to couple_rewards_path(current_user.couple), notice: 'Reward was successfully created.'
      else
        render :new
      end
    else
      redirect_to couple_rewards_path(current_user.couple), notice: "Gotta Slave More to have this Reward"
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:title, :description, :cost, :category, :date, :emoji)
  end
end
