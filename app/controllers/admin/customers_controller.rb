class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customers = Customer.all

  end

  def edit
    @customers = Customer.all
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.save
      flash[:notice] = "変更を保存しました"
      redirect_to admin_customer_path(@customer.id)
    else
      @customers = Customer.all
      render :show
    end
  end
  
end
