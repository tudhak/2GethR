class CouplesController < ApplicationController
  def show
    set_user
    set_couple
    set_partner
    @actions_received = @user.received_actions
    @received_actions = @actions_received.nil? ? [] : @actions_received.split(";")
    @nb_actions = @received_actions.size

    # For users who have created their account and couple, waiting for their partner to join
    if @partner.nil? || @partner.statues.empty?
    # For couple members who have both joined (standard case)
    else
      @status_id_max = @partner.statues.map(&:id).max
      @last_status_id = @partner.statues.last.id
      @partner_mood_img = @partner.statues == [] ? MoodCategory.last.image_path : Statue.find(@status_id_max).mood_category.image_path
      @partner_mood_sound = set_mood_sound
    end
  end

  def chatroom
    @couple = Couple.find(params[:id])
    @message = Message.new
  end

  def punch_action
    show
    if @partner.received_actions.nil?
      then @partner.received_actions = "punch;"
    else
      @partner.received_actions += "punch;"
    end
    @partner.save
  end

  def love_action
    show
    if @partner.received_actions.nil?
      then @partner.received_actions = "love;"
    else
      @partner.received_actions += "love;"
    end
      @partner.save
  end

  def peace_action
    show
    if @partner.received_actions.nil?
      then @partner.received_actions = "peace;"
    else
      @partner.received_actions += "peace;"
    end
    @partner.save
  end

  def kiss_action
    show
    if @partner.received_actions.nil?
      then @partner.received_actions = "kiss;"
    else
      @partner.received_actions += "kiss;"
    end
    @partner.save
  end

  def delete_action
    show
    @user.received_actions.nil?
    @user.save
  end

  private

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
