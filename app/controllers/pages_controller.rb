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

    @user_tasks = tasks_metrics["user_prop"].to_json
    @partner_tasks = tasks_metrics["partner_prop"].to_json
    # @user_tasks = {dishwashing: 0.3, laundry: 0.6, cleaning: 0.2, cooking: 0.4 }.to_json
    # @partner_tasks = {dishwashing: 0.7, laundry: 0.4, cleaning: 0.8, cooking: 0.6 }.to_json

    # @user_rewards = rewards_metrics(@user)
    # @partner_tasks = rewards_metrics(@partner)
    @user_rewards =     { massage: 100, restaurant: 50, we: 75, cine: 20, fleur: 10, cadeau: 40, homiesnight: 75, breakfast: 30 }.to_json
    @partner_rewards =  { massage: 80, restaurant: 20, we: 35, cine: 10, fleur:40, cadeau: 5, homiesnight: 30, breakfast: 15 }.to_json

    # @user_period_tasks_points = tasks_points(@user)
    # @partner_period_tasks_points = tasks_points(@partner)
    @user_period_tasks_points = 40
    @partner_period_tasks_points = -20

    # @user_period_rewards_points = rewards_points(@user)
    # @partner_period_rewards_points = rewards_points(@partner)
    @user_period_rewards_points = 30
    @partner_period_rewards_points = -20
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


  def opening_date
    openingdate = (Date.today - 7)
  end

  def mood_summary(user)
    opening_date
    openingtime = opening_date.to_time
    status_scope = user.statues.all.where('created_at > ?', openingtime)
    statuses_duration = {"stormy"=>0, "rainy"=>0, "cloudy"=>0, "sunny"=>0}
    cumul_duration = 0
    status_scope.each do |status|
      mood = status.mood_category.title
      start_time = [status.created_at, openingtime].max
      end_time = status.end_date == nil ? Time.now : status.end_date
      mood_duration = end_time - start_time
      cumul_duration =+ mood_duration
      statuses_duration[mood] = statuses_duration[mood]&. + mood_duration
    end
    return [statuses_duration, cumul_duration]
  end

  def tasks_metrics
    user_nickname = @user.nickname
    partner_nickname = @partner.nickname
    tasks_scope = Task.all.where('(done_by = ? OR done_by = ?) AND date >= ?', @user.nickname,  @partner.nickname, opening_date)
    gen_tasks = GenericTask.where(couple: current_user.couple).pluck(:title)
    gen_tasks = !gen_tasks.include?("Other") ? gen_tasks + ["Other"] : gen_tasks
    tasks_summary = {user_nickname => {}, partner_nickname => {}, "couple" => {}, "user_prop" => {}, "partner_prop" => {} }
    tasks_scope.each do |task|
      task_title = gen_tasks.include?(task.title) ? task.title : "Other"
      tasks_summary[task.done_by][task_title] = tasks_summary[task.done_by][:task_title].nil? ? task.base_score : tasks_summary[task.done_by][:task_title] + task.base_score
      tasks_summary["couple"][task_title] = tasks_summary["couple"][:task_title].nil? ? task.base_score : tasks_summary["couple"][:task_title] + task.base_score
    end
    tasks_summary["user_prop"] = tasks_summary["couple"].map do |key, value|
      [key, tasks_summary[user_nickname][key].to_f / value.to_f]
    end.compact.to_h
    tasks_summary["partner_prop"] = tasks_summary["couple"].map do |key, value|
      [key, tasks_summary[partner_nickname][key].to_f / value.to_f]
    end.compact.to_h
    return tasks_summary
  end

  def rewards_metrics(user)
    "hello"
  end

  def tasks_points(user)
    "hello"
  end

  def rewards_points(user)
    "hello"
  end

end
