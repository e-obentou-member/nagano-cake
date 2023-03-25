class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    # @cart_items = current_customer.cart_items.all
    # @total_price =  @cart_items.sum(&:subtotal_price)
    @postage = 800
  end
end
