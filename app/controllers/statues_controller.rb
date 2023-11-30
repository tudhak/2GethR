class StatuesController < ApplicationController

  def new
    @statue = Statue.new
  end

  def create
    @statue = Statue.new(statue_params)
    @last_status = current_user.status.last
    @statue.save
    if @last_status != nil
      then @last_status.end_date = @statue.created_at
    end
    @last_status.save
  end

  private

  def statue_params
    params.require(:statue).permit(:main_statue_message, :love_statue_message, :hate_statue_message, :mood_category_id)
  end

end
