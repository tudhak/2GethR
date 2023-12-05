class PagesController < ApplicationController

  def home
    set_user
    set_couple
    set_partner
    @actions_received = @user.received_actions
    @received_actions = @actions_received == nil ? [] : @actions_received.split(";")
    @nb_actions = @received_actions.size
    @partner_mood_img = @partner.statues == [] ? MoodCategory.last.image_path : @partner.statues.last.mood_category.image_path
  end

  def punch_action
    home
    if @partner.received_actions == nil
      then @partner.received_actions = "punch;"
    else
      @partner.received_actions += "punch;"
    end
    @partner.save
  end

  def love_action
    home
    if @partner.received_actions == nil
      then @partner.received_actions = "love;"
    else
      @partner.received_actions += "love;"
    end
      @partner.save
  end

  def peace_action
    home
    if @partner.received_actions == nil
      then @partner.received_actions = "peace;"
    else
      @partner.received_actions += "peace;"
    end
    @partner.save
  end

  def kiss_action
    home
    if @partner.received_actions == nil
      then @partner.received_actions = "kiss;"
    else
      @partner.received_actions += "kiss;"
    end
    @partner.save
  end

  def delete_action
    home
    @user.received_actions = nil
    @user.save

  end

  def score
    home
    # @user_mood = mood_summary(@user)
    # @partner_mood = mood_summary(@partner)
    @user_mood = {sunny: 0.2, stormy: 0.3, rainy: 0.4, cloudy: 0.1 }.to_json
    @partner_mood = {sunny: 0.3, stormy: 0.1, rainy: 0.2, cloudy: 0.4 }.to_json
    @user_tasks = {dishwashing: 0.3, laundry: 0.6, cleaning: 0.2, cooking: 0.4 }.to_json
    @partner_tasks = {dishwashing: 0.7, laundry: 0.4, cleaning: 0.8, cooking: 0.6 }.to_json
    # raise
  end

  private

#------------ 1. set user, partner, couple------------------------------------

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

  #------------ 2. Set variables for score--------------------------------------

  def mood_summary(user)
    opening_date = (Date.today - 7).to_time
    status_scope = user.statues.all.where('created_at > ?', opening_date)
    statuses_duration = {"stormy"=>0, "rainy"=>0, "cloudy"=>0, "sunny"=>0}
    cumul_duration = 0
    status_scope.each do |status|
      mood = status.mood_category.title
      start_date = [status.created_at, opening_date].max
      end_date = status.end_date == nil ? Time.now : status.end_date
      mood_duration = end_date - start_date
      cumul_duration =+ mood_duration
      statuses_duration[mood] = statuses_duration[mood]&. + mood_duration
    end
    return [statuses_duration, cumul_duration]
  end

  def couple_task_split
    "hello"
  end

  def couple_reward_split
    "hello"
  end

end
