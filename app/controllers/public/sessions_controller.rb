# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_out_path_for(resource)
    flash[:notice] = "お疲れ様でした"
    public_homes_top_path
  end
  def after_sign_in_path_for(resource)
    flash[:notice] = "ラーメンMapへお帰りなさい"
    public_customer_path(current_customer.id)
  end

  #protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password])
    end
    redirect_to public_homes_top_path
  end

  def new_guest
    user = Customer.guest
    sign_in user
    redirect_to public_homes_top_path, flash[:notice] = 'ゲストユーザーとしてログインしました。'
  end


end
