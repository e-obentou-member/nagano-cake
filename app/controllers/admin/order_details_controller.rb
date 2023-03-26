class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      flash[:notice] = "変更を保存しました"
      redirect_to admin_order_path(@order.id)
    else
      render :show
    end
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:make_status)
  end
end
