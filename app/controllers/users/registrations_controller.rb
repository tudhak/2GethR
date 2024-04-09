# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_user, only: %i[edit update pending]
  before_action :set_couple, only: %i[edit update]
  skip_before_action :check_confirmed_user

  # GET /resource/sign_up
  def new
    super do
      @couple = Couple.new
    end
  end

  # POST /resource
  def create
    # super do
    @user = User.new(user_params)
    @user.score = 0
    # Checking if user has entered a couple token
    if params[:couple][:token].present?
      @couple_to_find = Couple.find_by_token_for(:check_couple, params[:couple][:token])
      # If couple token is valid, user couple is set to found couple
      if @couple_to_find
        @couple = @couple_to_find
        @user.couple = @couple
        @user.confirmed = false
        redirect_to pending_path if @user.save
        return
      else
        # If couple token is invalid, new empty couple is instantiated so that @couple exists in the view
        @couple = Couple.new
      end
    else
      # If no couple token is entered by user, new couple is instantiated from user input (couple nickname and couple address)
      # New couple is created with new couple token
      # TODO: To be refactored. This code allows to create a couple independently from a user (if couple info is correct and user info is not, the couple could be created but not the user)
      @couple = Couple.new(couple_params)
      if @couple.save
        @couple.token = @couple.generate_token_for(:check_couple)
        @couple.save
        @user.couple = @couple
      else
        flash[:alert] = "Your account could not be created. Please review the form."
        render :new, status: :unprocessable_entity
        return
      end
    end
    if @user.save
      # confirm first couple partner - to be refactored later
      @user.confirmed = true
      @user.save
      redirect_to couple_path(@couple)
      flash[:notice] = "Account successfully created!"
    else
      render :new, status: :unprocessable_entity
      flash[:alert] = "Your account could not be created. Please review the form."
    end

      # build_resource(configure_sign_up_params)
      # resource.score = 0
      # resource.save
      # if resource.persisted?
      #   # redirect_to couple_path(@couple)
      #   set_flash_message! :notice, :signed_up
      #   sign_up(resource_name, resource)
      #   respond_with resource, location: after_sign_up_path_for(resource)
      #   flash[:notice] = "Account successfully created!"
      # else
      #   render :new, status: :unprocessable_entity
      #   flash[:alert] = "Your account could not be created. Please review the form."
      # end
    # end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def pending
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password attribute password_confirmation first_name last_name nickname date_of_birth mode photo])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :nickname, :date_of_birth, :mode, :photo)
  end

  def couple_params
    params.require(:couple).permit(:address, :nickname)
  end
end
