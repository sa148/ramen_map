class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = current_customer
  end

  def update
     @customer = current_customer
     if @customer.update(customer_params)
       redirect_to public_homes_top_path
       flash[:notice] = "ご登録情報の変更が終了しました"
     else
       flash[:notice] = "変更が失敗しました"
       render 'edit'
     end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to public_homes_top_path
  end

  private

  def  customer_params
    params.require(:customer).permit(:email, :name, :birthday, :is_deleted, :password)
  end
end


