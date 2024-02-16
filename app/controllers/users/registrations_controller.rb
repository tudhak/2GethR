# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(user_params)
    if params[:token].present?
      @couple = Couple.find_by_token_for(:check_couple, params[:token])
      @user.couple = @couple
    else
      @couple = Couple.new(couple_params)
      @couple.token = @couple.generate_token_for(:check_couple)
      if @couple.save
        @user.couple = @couple
      else
        render :new, status: :unprocessable_entity
        flash[:alert] = "Your account could not be created. Please review the form."
      end
    end
    if @user.save
      redirect_to root_path
      flash[:notice] = "Account successfully created!"
    else
      render :new, status: :unprocessable_entity
      flash[:alert] = "Your account could not be created. Please review the form."
    end
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
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
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
    params.require(:user).permit(:email, :password, :first_name, :last_name, :nickname, :date_of_birth, :mode, :photo)
  end

  def couple_params
    params.require(:couple).permit(:address, :nickname)
  end
end
