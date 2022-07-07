class Public::ContributionsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]
  before_action :correct_contribution, only: [:edit, :update]

  def new
    @contribution = Contribution.new
  end

  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.customer_id = current_customer.id
    @tag_list = params[:contribution][:tag_name].split("、")
    if @contribution.save
       @contribution.save_tag(@tag_list)
       redirect_to public_contributions_path
       flash[:notice] = "投稿が完了しました"
    else
       flash[:notice] = "投稿が失敗しました"
       render 'new'
    end
  end

  def index
    @contributions = Contribution.all
    @customers = Customer.all
  end

  def show
    @contribution = Contribution.find(params[:id])
    @contribution_tags = @contribution.tags
    @tag_list = Tag.all
    @tags = Tag.all
  end

  def edit
    @contribution = Contribution.find(params[:id])
  end

  def update
    @contribution = Contribution.find(params[:id])
    @contribution.update(contribution_params)
    redirect_to public_contributions_path
    flash[:notice] = "投稿の変更が完了しました"
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
    @customers = Customer.all
    if params[:tag_id] != nil
      @contributions = Tag.find_by(id: params[:tag_id]).contributions
      flash[:notice] = "投稿の検索に成功しました"
    end
    @tag_list = Tag.all
  end



  private

  def  contribution_params
    params.require(:contribution).permit(:customer_id, :menu_id, :title, :star, :comment, :image, :tag_list)
  end

end
