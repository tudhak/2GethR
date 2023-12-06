class CouplesController < ApplicationController

  def show
    set_user
    set_partner
    set_couple
    @couple = Couple.find(params[:id])
    @actions_received = @user.received_actions
    @received_actions = @actions_received == nil ? [] : @actions_received.split(";")
    @nb_actions = @received_actions.size
    @status_id_max = @partner.statues.map(&:id).max
    @last_status_id = @partner.statues.last.id
    @partner_mood_img = @partner.statues == [] ? MoodCategory.last.image_path : Statue.find(@status_id_max).mood_category.image_path
    # raise
  end

  def chatroom
    @couple = Couple.find(params[:id])
    @message = Message.new
  end

  private

  def set_user
    @user = current_user
  end

  def set_couple
    @couple = current_user.couple
  end

  def set_partner
    set_couple
    @partner = (@couple.users - [current_user])[0]
  end
end
