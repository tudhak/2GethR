class StatuesController < ApplicationController
  before_action :set_user, :set_partner, only: %i[new show create]
  before_action :set_couple, only: [:create]

  def new
    @statue = Statue.new
  end

  def show
    return if @user.statues.empty?

    @statue = @user.statues.last
    @user_mood_img = @statue.mood_category.image_path
  end

  def create
    @statue = Statue.new(statue_params)
    @statue.user = @user
    @last_status = current_user.statues.last unless @user.statues.empty?
    if @statue.save
      @statue.start_date = @statue.created_at
      @statue.save
      if @last_status
        @last_status.end_date = @statue.start_date
        @last_status.save
      end
      redirect_to statue_path(current_user.statues.last)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def statue_params
    params.require(:statue).permit(:main_statue_message, :love_statue_message, :hate_statue_message, :mood_category_id)
  end
end
