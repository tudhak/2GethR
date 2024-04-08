class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_user, only: %i[score scoredetails]
  before_action :set_couple, only: %i[scoredetails]
  before_action :set_partner, only: %i[score scoredetails]

  def home
  end

  def score
    @user_mood = mood_summary(@user)[1] == 0 ? { sunny: 0, stormy: 0, rainy: 0, cloudy: 0 }.to_json : mood_summary(@user)[0].map do |mood, duration| [mood, duration / mood_summary(@user)[1]] end.compact.to_h.to_json
    @partner_mood = @partner.nil? || mood_summary(@partner)[1] == 0 ? { sunny: 0, stormy: 0, rainy: 0, cloudy: 0 }.to_json : mood_summary(@partner)[0].map do |mood, duration| [mood, duration / mood_summary(@partner)[1]] end.compact.to_h.to_json
    @partner_score = @partner.nil? ? 0 : @partner.score
    @partner_nickname = @partner.nil? ? "???" : @partner.nickname
    # @user_mood = {sunny: 0.2, stormy: 0.3, rainy: 0.4, cloudy: 0.1 }.to_json
    # @partner_mood = {sunny: 0.3, stormy: 0.1, rainy: 0.2, cloudy: 0.4 }.to_json

    @user_tasks_prop = tasks_metrics["user_prop"].to_json
    @partner_tasks_prop = tasks_metrics["partner_prop"].to_json
    @categories = tasks_metrics["couple"].keys

    # @user_tasks = {dishwashing: 0.3, laundry: 0.6, cleaning: 0.4, cooking: 0.6, shopping: 0.5 }.to_json
    # @partner_tasks = {dishwashing: 0.7, laundry: 0.4, cleaning: 0.8, cooking: 0.4, shopping: 0.5 }.to_json

    @user_rewards = rewards_metrics(@user)
    @partner_tasks = @partner.nil? ? "None" : rewards_metrics(@partner)
    # @user_rewards =     { massage: 100, restaurant: 50, we: 75, cine: 20, fleur: 10, cadeau: 40, homiesnight: 75, breakfast: 30 }.to_json
    # @partner_rewards =  { massage: 80, restaurant: 20, we: 35, cine: 10, fleur:40, cadeau: 5, homiesnight: 30, breakfast: 15 }.to_json

    @user_period_tasks_points = tasks_points(@user)
    @partner_period_tasks_points = @partner.nil? ? 0 : tasks_points(@partner)
    # @user_period_tasks_points = 40
    # @partner_period_tasks_points = 20

    @user_period_rewards_points = rewards_points(@user)
    @partner_period_rewards_points = @partner.nil? ? 0 : rewards_points(@partner)
    # @user_period_rewards_points = 30
    # @partner_period_rewards_points = 20
    # raise
  end

  def scoredetails
    @task = params[:title]
    @user_tasks = Task.all.where('done_by = ? AND date >= ? AND title = ?', @user.nickname,  opening_date, @task)
    @partner_tasks = Task.all.where('done_by = ? AND date >= ? AND title = ?', @partner.nickname,  opening_date, @task)
    @user_task_credit = @user_tasks.map { |task| task[:base_score] }.sum
    @partner_task_credit = @partner_tasks.map { |task| task[:base_score] }.sum
    @user_task_nb = @user_tasks.map { |task| task[:base_score] }.size
    @partner_task_nb = @partner_tasks.map { |task| task[:base_score] }.size
  end

  private

  #------------ Set variables for score--------------------------------------

  def opening_date
    Date.today - 30
  end

  def mood_summary(user)
    opening_date
    openingtime = opening_date.to_time
    status_scope = user.statues.all.where('end_date > ?', openingtime)
    statuses_duration = { "stormy" => 0, "rainy" => 0, "cloudy" => 0, "sunny" => 0 }
    status_scope.each do |status|
      mood = status.mood_category.title
      start_time = [status.start_date, openingtime].max
      end_time = status.end_date == nil ? Time.now : status.end_date
      mood_duration = end_time - start_time
      statuses_duration[mood] = statuses_duration[mood]&. + mood_duration
    end
    return [statuses_duration, statuses_duration.values.sum]
  end

  def tasks_metrics
    user_nickname = @user.nickname
    partner_nickname = @partner.nil? ? "???" : @partner.nickname
    tasks_scope = Task.all.where('(done_by = ? OR done_by = ?) AND date >= ?', @user.nickname, partner_nickname, opening_date)
    gen_tasks = GenericTask.where(couple: current_user.couple).pluck(:title)
    gen_tasks = !gen_tasks.include?("Other") ? gen_tasks + ["Other"] : gen_tasks
    tasks_summary = {user_nickname => {}, partner_nickname => {}, "couple" => {}, "user_prop" => {}, "partner_prop" => {} }
    tasks_scope.each do |task|
      task_title = gen_tasks.include?(task.title) ? task.title : "Other"
      tasks_summary[task.done_by][task_title] = tasks_summary[task.done_by][task_title].nil? ? task.base_score : tasks_summary[task.done_by][task_title] + task.base_score
      tasks_summary["couple"][task_title] = tasks_summary["couple"][task_title].nil? ? task.base_score : tasks_summary["couple"][task_title] + task.base_score
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
    rewards_scope = user.rewards.where('date >= ?', opening_date)
    gen_rewards = GenericReward.where(couple: user.couple).pluck(:title)
    gen_rewards = !gen_rewards.include?("Other") ? gen_rewards + ["Other"] : gen_rewards
    rewards_summary = { }
    rewards_scope.each do |reward|
      reward_title = gen_rewards.include?(reward.title) ? reward.title : "Other"
      rewards_summary[reward_title] = rewards_summary[reward_title].nil? ? reward.cost : rewards_summary[reward_title] + reward.cost
    end
    return rewards_summary
  end

  def tasks_points(user)
    tasks_metrics[user.nickname].values.sum
  end

  def rewards_points(user)
    rewards_metrics(user).values.sum
  end

end
