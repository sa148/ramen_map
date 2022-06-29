class Public::ContributionsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]
  before_action :correct_contribution, only: [:edit, :update]

  def new
    @contribution = Contribution.new
  end

  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.customer_id = current_customer.id
    @contribution.save
    redirect_to public_contributions_path
  end

  def index
    @contributions = Contribution.all
    @customers = Customer.all
    #@customer = current_customer
    #@customers.name = Contribution.customer.name
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  def edit
    @contribution = Contribution.find(params[:id])
  end

  def update
    @contribution = Contribution.find(params[:id])
    @contribution.update(contribution_params)
    redirect_to public_contributions_path
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    if @contribution.customer_id == current_customer.id
        @contribution.destroy
        redirect_to public_contributions_path
        flash[:notice] = "投稿を削除しました"
    else
        redirect_to public_contributions_path
        flash[:notice] = "他人の投稿は削除できません"
    end
  end

  def correct_contribution
    @contribution = Contribution.find(params[:id])
    unless @contribution.customer.id == current_customer.id
        redirect_to public_contributions_path, notice: 'このページへは遷移できません。'
    end
  end

  def search
    @contributions = Contribution.all
    if params[:title].present?
      @contributions = Contribution.where('title LIKE ?', "%#{params[:title]}%")
    else
      @contributions = Contribution.none
    end
  end



  private

  def  contribution_params
    params.require(:contribution).permit(:customer_id, :menu_id, :title, :star, :comment, :image)
  end

end
