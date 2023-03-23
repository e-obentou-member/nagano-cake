class Public::OrdersController < ApplicationController
#   def new
#     @customer = current_customer
#     @order = Order.new
#   end

#   def index
#   end

#   def show
#   end

#   def check
#     @order = Order.new(order_params
#     )
#     @newaddress = Order.new(order_params)
#     @newaddress.customer_id = current_customer.id
#   end

#   def create
#     cart_items = current_customer.cart_items.all
#     # ログインユーザーのカートアイテムをすべて取り出す
#     @order = current_customer.orders.new(order_params)
#     # わたってきた値を@orderに入れます
#     if @order.save
#       cart_items.each do |cart|
#         # 取り出したカートアイテムの数繰り返します
# # order_item にも一緒にデータを保存する必要があるのでここで保存します
#       order_item = OrderItem.new
#       order_item.item_id = cart.item_id
#       order_item.order_id = @order.id
#       order_item.order_quantity = cart.quantity
#       # 購入が完了したらカート情報は削除するのでこちらに保存します
#         order_item.order_price = cart.item.price
# # カート情報を削除するので item との紐付けが切れる前に保存します
#       order_item.save
#     end
#     redirect_to orders_done_path
#     cart_items.destroy_all
#     # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
#     else
#     @order = Order.new(order_params)
#     render :new
#     end
#     if @newaddress.save
#     redirect_to orders_done_path
#     else
#     render :new
#     end
#   end



#   def done
#   end

#   private

#   def order_params
#     params.require(:order).permit(:postcode, :address, :name)
#   end
end
