class RewardsController < ApplicationController
  before_action :authenticate_user!

  def given_rewards
    @rewards = current_user.rewards
    render 'given_rewards'
  end

  def to_do_rewards
    @other_person = User.select {|user| user.couple_id == current_user.couple_id }.first
    @to_do_rewards = @other_person.rewards
  end

  def new
    @reward = Reward.new
  end

  def create
    @reward = current_user.rewards.build(reward_params)

    if @reward.save
      redirect_to given_rewards_rewards_path, notice: 'Reward was successfully created.'
    else
      render :new
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:title, :description, :cost, :category)
  end
end
