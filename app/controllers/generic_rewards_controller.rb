class GenericRewardsController < ApplicationController
  def index
    @generic_rewards = GenericReward.all
  end

  def show
    @generic_reward = GenericReward.find(params[:id])
    @reward = Reward.new(title: @generic_reward.title, description: @generic_reward.description, cost: @generic_reward.cost)
  end

  def generic_reward_params
    params.require(:generic_reward).permit(:title, :description, :cost, :emoji)
  end

end
