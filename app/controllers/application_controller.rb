class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_confirmed_user

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nickname, :date_of_birth, :mode, :photo])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nickname, :date_of_birth, :mode, :photo, :confirmed])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  # Setting these helper functions once, which are used throughout the app

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

  def partner_nickname
    # Safe navigation operator
    @partner_nickname = @partner&.confirmed ? @partner.nickname : "???"
  end

  def partner_picture
    # Safe navigation operator
    @partner_picture = @partner&.photo&.key ? @partner.photo.key : "unknown_person.jpg"
  end

  def check_confirmed_user
    set_user
    set_partner
    return if @user.confirmed == true || @user.rejected_by.include?(@partner.id)

    flash[:error] = "Your profile has not yet been confirmed by your partner."
    redirect_to pending_path
  end
end
