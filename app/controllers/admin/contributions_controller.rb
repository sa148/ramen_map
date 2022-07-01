class Admin::ContributionsController < ApplicationController

  def index
    @contributions = Contribution.all
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to admin_contributions_path
  end

  private

  def  contribution_params
    params.require(:contribution).permit(:customer_id, :menu_id, :title, :star, :comment, :image)
  end

end
