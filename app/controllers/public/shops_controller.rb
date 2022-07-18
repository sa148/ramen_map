class Public::ShopsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:menu_name, :menu_introduction, :price, :name, :introduction, :telephone_number, :email, :image, :latitude, :longitude, :address)
  end

end
