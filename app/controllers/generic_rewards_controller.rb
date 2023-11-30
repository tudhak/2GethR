class GenericRewardsController < ApplicationController
  def index
    @generic_rewards = GenericReward.all
  end

  def show
    @generic_reward = GenericReward.find(params[:id])
  end


end
