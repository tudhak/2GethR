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
    @partner_mood_sound =   set_mood_sound
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

  def set_mood_sound
    mood_title = Statue.find(@status_id_max).mood_category.title
    mood = {
      "rainy" => "rain.mp3",
      "cloudy" => "cloud.mp3",
      "sunny" => "sun.mp3",
      "stormy" => "storm.mp3"
    }
    mood[mood_title]
  end
end
