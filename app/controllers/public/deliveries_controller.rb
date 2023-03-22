class Public::DeliveriesController < ApplicationController

  def create
    @delivery_new = Delivery.new(delivery_params)
    @delivery_new.customer_id = current_customer.id
    if @delivery_new.save
      redirect_to deliveries_path
    else
      @customer = current_customer
      @deliveries = @customer.deliveries
      render :index
    end
  end

  def index
    @customer = current_customer
    @deliveries = @customer.deliveries
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
   if delivery.update(delivery_params)
    redirect_to deliveries_path
   else
    render edit_delivery_path
   end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    # ↓画面遷移しないやつ
    redirect_to request.referer
  end

   private

  def delivery_params
    params.require(:delivery).permit(:postcode, :address, :name)
  end




end
