class StatuesController < ApplicationController

  def new
    set_user
    set_partner
    @statue = Statue.new
    # raise
  end

  def show
    set_partner
    @statue = current_user.statues.last
    @user_mood_img = @statue.mood_category.image_path
    # raise
  end

  def create
    set_user
    set_couple
    set_partner
    @statue = Statue.new(statue_params)
    @statue.user = current_user
    @last_status = current_user.statues.last
    if @statue.save
      @statue.start_date = @statue.created_at
      @statue.save
      if @last_status != nil
        then @last_status.end_date = @statue.start_date
      end
      @last_status.save
      # raise
      redirect_to statue_path(current_user.statues.last)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def autopilot_toggle
    last_status = current_user.statues.last
    if last_status.present?
    new_status = Statue.new(
      main_statue_message: last_status.main_statue_message,
      love_statue_message: last_status.love_statue_message,
      hate_statue_message: last_status.hate_statue_message,
      mood_category_id: last_status.mood_category_id,
      user_id: last_status.user_id,
      autopilot: !last_status.autopilot)
    else
      new_status = Statue.new(
        user_id: current_user,
        autopilot: true)
    end
    new_status.save
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

    def statue_params
      params.require(:statue).permit(:main_statue_message, :love_statue_message, :hate_statue_message, :mood_category_id)
    end

end
