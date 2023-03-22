class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
      if @customer.update(customer_params)
        redirect_to customers_mypage_path
      else
          render :edit
      end
  end

  def check
     @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_delete: true)
    reset_session
    redirect_to destroy_customer_session_path
  end

    private


  def customer_params
    params.require(:customer).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :postcode, :address, :telephone_number, :email) #保存を許すカラム
  end
end

