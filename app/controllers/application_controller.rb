class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nickname, :date_of_birth, :mode, :photo])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nickname, :date_of_birth, :mode, :photo])
  end

  def home
    set_user
    set_couple
    set_partner
    @actions_received = @user.received_actions
    @received_actions = @actions_received == nil ? [] : actions_received.split(";")
    @nb_actions = @received_actions.size
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

end
