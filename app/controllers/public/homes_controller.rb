class Public::HomesController < ApplicationController

  def top
  end

  def new_guest
    user = Customer.find_or_create_by!(name: 'Map', birthday: '1111', email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to public_homes_top_path  flash[:notice] = 'ゲストユーザーとしてログインしました。'
  end

end
