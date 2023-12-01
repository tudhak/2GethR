class UsersController < ApplicationController

  def edit
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
  end

end
