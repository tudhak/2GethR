# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_user, :set_couple, only: [:edit, :update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # super do
    @user = User.new(user_params)
    @user.score = 0
    if params[:couple][:token].present?
      @couple = Couple.find_by_token_for(:check_couple, params[:couple][:token])
      @user.couple = @couple
    else
      @couple = Couple.new(couple_params)
      @couple.token = @couple.generate_token_for(:check_couple)
      if @couple.save
        @user.couple = @couple
      else
        flash[:alert] = "Your account could not be created. Please review the form."
        render :new, status: :unprocessable_entity
        return
      end
    end
    if @user.save
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
    params.require(:couple).permit(:address, :nickname, :couple)
  end
end
