class GenericRewardsController < ApplicationController
  def index
    @generic_rewards = GenericReward.all
  end

  def show
    @generic_reward = GenericReward.find(params[:id])
    @reward = Reward.new(title: @generic_reward.title, description: @generic_reward.description, cost: @generic_reward.cost)
  end

end
