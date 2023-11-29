class GenericRewardsController < ApplicationController
  def index
    @generic_rewards = GenericReward.all
  end
end
