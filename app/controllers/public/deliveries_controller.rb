class Public::DeliveriesController < ApplicationController
  
  def create
    @delivery_new = Delivery.new(delivery_params)
    @delivery_new.customer_id = current_customer.id
    if @delivery_new.save
      redirect_to '/deliveries'
    else
      @deliveries = Delivery.all
      @customer = current_customer
      render :index
    end
  end
  
  def index
    @customer = Customer.find(params[:id])
    @deliveries = Delivery.all
    @delivery_new = Delivery.new
  end

  def show
     @delivery = Delivery.find(params[:id])
  end

  def edit
     @delivery = Delivery.find(params[:id])
  end
  
  def update
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to '/deliveries'
  end
  
  def destroy
  end
  
end
