class Admin::ShopsController < ApplicationController
  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to admin_homes_about_path
    else
      redirect_to new_admin_shop_path
    end
  end

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end

  private

  def shop_params
    params.require(:shop).permit(:menu_name, :menu_introduction, :price, :name, :introduction, :telephone_number, :email, :image, :latitude, :longitude, :address)
  end
end
