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
    # Méthode qui va considérer qu'un user 2 est le partenaire d'un user 1 s'il n'a pas été rejeté par user 1
    set_couple
    @partner = (@couple.users - [current_user]).find { |user| !user.rejected_by.include?(current_user.id) }
  end

  def partner_nickname
    # Safe navigation operator
    rejected?
    @partner_nickname = @partner&.confirmed && !@rejected ? @partner.nickname : "???"
  end

  def rejected?
    # Méthode qui va vérifier si un user a été rejeté par son partenaire -> restreint l'affichage des vues
    # Méthode réciproque a set_partner pour l'utilisateur refusé
    @rejected = current_user.rejected_by.include?(@partner.id) if @partner
  end

  def partner_picture
    # Safe navigation operator
    rejected?
    @partner_picture = @partner&.photo&.key && !@rejected ? @partner.photo.key : "unknown_person.jpg"
  end

  def check_confirmed_user
    set_user
    set_partner
    return if @user.confirmed == true || @user.rejected_by.include?(@partner.id)

    flash[:error] = "Your profile has not yet been confirmed by your partner."
    redirect_to pending_path
  end
end
