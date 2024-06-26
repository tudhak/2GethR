# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_user, only: %i[edit update pending confirmed rejected after_reject]
  before_action :set_couple, only: %i[edit update confirmed rejected after_reject]
  before_action :set_partner, only: %i[edit confirmed rejected after_reject]
  skip_before_action :check_confirmed_user

  # GET /resource/sign_up
  def new
    super do
      @couple = Couple.new
    end
  end

  # POST /resource
  # Ideally I would like to transfer this logic to the Model. However it is not straightforward
  # The couple has to be created only once all other fields are validated.
  # The creation of a couple is necessary for the user to be saved to the DB
  def create
    @user = User.new(user_params)
    @couple = Couple.new
    # Checking whether all validations besides couple existence are OK
    @user.save
    if @user.errors.full_messages.length == 1 && @user.errors.full_messages[0] == "Couple must exist"
      # Checking if user has entered a couple token
      if params[:couple][:token].present? && couple_token_check
        couple_assign
        return
      elsif params[:couple][:token].present? && !couple_token_check
        new_couple_error("Your couple token is invalid.")
        return
      else
        return if couple_create == false
      end
      @user.confirmed = true
      @user.save
      redirect_to new_user_session_path
      flash[:notice] = "Account successfully created!"
    else
      new_couple_error("Your account could not be created. Please review the user information provided.")
    end
  end

  def after_reject
    if params[:couple][:token].present?
      @couple_to_find = Couple.find_by_token_for(:check_couple, params[:couple][:token])
      if @couple_to_find && !rejected_by_couple_owner?(@couple_to_find) && !full_couple?(@couple_to_find) && @user.update_without_password(couple: @couple_to_find, confirmed: false)
        redirect_to pending_path
        flash[:notice] = "You succesfully requested to join another couple."
      elsif @couple_to_find && full_couple?(@couple_to_find)
        render partial: "couples/rejected_modal", locals: { user: @user, partner: @partner }, status: :unprocessable_entity
        flash[:alert] = "This couple is already full!"
      elsif @couple_to_find && rejected_by_couple_owner?(@couple_to_find)
        render partial: "couples/rejected_modal", locals: { user: @user, partner: @partner }, status: :unprocessable_entity
        flash[:alert] = "Sorry, you can't join this couple. #{@couple_to_find.users.min_by(&:created_at).nickname} already declined your request."
      elsif !@couple_to_find
        render partial: "couples/rejected_modal", locals: { user: @user, partner: @partner }, status: :unprocessable_entity
        flash[:alert] = "Wrong couple token provided."
      end
    else
      @couple = Couple.new(couple_params)
      # The token can only be generated if the record exists (we need first to save it to the DB)
      if @couple.save
        @couple.token = @couple.generate_token_for(:check_couple)
        @couple.save
        @user.update_without_password(couple: @couple, confirmed: true)
        redirect_to couples_path(@couple)
        flash[:notice] = "You successfully created a couple!"
      else
        flash[:alert] = "Your couple could not be created. Please review the form."
        render partial: "couples/rejected_modal", locals: { user: @user, partner: @partner }, status: :unprocessable_entity
        return
      end
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

  def pending
  end

  def confirmed
    if @partner.update_without_password(confirmed: true)
      redirect_to couple_path(@couple)
      flash[:notice] = "You accepted #{@partner.nickname}'s request."
    else
      render partial: "couples/confirm_partner_modal", locals: { partner: @partner }, status: :unprocessable_entity
      flash[:alert] = "An error occurred."
    end
  end

  def rejected
    updated_rejects = @partner.rejected_by.push(@user.id)
    if @partner.update_without_password(rejected_by: updated_rejects)
      redirect_to couple_path(@couple)
      flash[:alert] = "You declined #{@partner.nickname}'s request."
    else
      render partial: "couples/confirm_partner_modal", locals: { partner: @partner}, status: :unprocessable_entity
      flash[:notice] = "An error occurred."
    end
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

  def couple_token_check
    @couple_to_find = Couple.find_by_token_for(:check_couple, params[:couple][:token])
  end

  def new_couple_error(message)
    render :new, status: :unprocessable_entity
    flash[:alert] = message
  end

  def full_couple?(couple)
    # En principe couple.users.min_by(&:created_at) permet de récupérer le 1er utilisateur, qui a crée le couple. C'est en fonction de lui/elle qu'on vérifie
    # s'il / elle a rejeté les autres users
    couple.users.reject { |user| user.rejected_by.include?(couple.users.min_by(&:created_at).id) }.length >= 2
  end

  def rejected_by_couple_owner?(couple)
    current_user.rejected_by.include?(couple.users.min_by(&:created_at).id)
  end

  def couple_assign
    # If couple token is valid, user couple is set to found couple
    # couple_token_check
    @couple = @couple_to_find
    if full_couple?(@couple_to_find)
      new_couple_error("This couple is already full!")
    else
      @user.couple = @couple
      @user.confirmed = false
      @user.save
      redirect_to pending_path
    end
  end

  def couple_create
    # If no couple token is entered by user, new couple is instantiated from user input (couple nickname and address)
    # New couple is created with new couple token
    @couple = Couple.new(couple_params)
    # The token can only be generated if the record exists (we need first to save it to the DB)
    if @couple.save
      @couple.token = @couple.generate_token_for(:check_couple)
      @couple.save
      @user.couple = @couple
    else
      new_couple_error("Your account could not be created. Please review the couple information provided.")
      false
    end
  end
end
