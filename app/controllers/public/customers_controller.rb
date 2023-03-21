class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to customer_path(@customer.id)
      else
          render :edit
      end
  end

  def check
  end

  def reject_customers
  end
  
    private
    
    
  def customer_params
    params.require(:customer).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :postcode, :address, :telephone_number, :email) #保存を許すカラム
  end
end

