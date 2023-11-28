class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = current_user
  end

  def score

  end

  private

  def set_partner
    @couple = Couple.find(current_user.couple_id)
    @partner = User.where(@couple) - current_user
  end

  def score_user
    @score_user = current_user.score
  end

  def score_partner
    @score_partner = User.find(current_user.id)
  end

end
