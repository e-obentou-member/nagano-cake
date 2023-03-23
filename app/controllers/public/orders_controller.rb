class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
    
    # 注文情報入力画面に表示させるのに使う
    @addresses = Address.all
  end

  def index
      @customer = current_customer
      @orders = @customer.orders
  end

  def show
      @menu = Menu.find(params[:menu_id])
      @order = @menu.order.new
  end

  def check
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
        # view で定義している address_number が"1"だったときにこの処理を実行します
# form_with で @order で送っているので、order に紐付いた address_number となります。以下同様です
# この辺の紐付けは勉強不足なので gem の pry-byebug を使って確認しながら行いました
    @order.name = current_customer.name
    @order.address = current_customer.customer_address
    
    elsif params[:order][:address_number] == "2"
        
    
    @newaddress = Order.new(order_params)
    @newaddress.customer_id = current_customer.id
  end

# 注文を確定します
  def create
    cart_items = current_customer.cart_items.all
    # ログインユーザーのカートアイテムをすべて取り出す
    @order = current_customer.orders.new(order_params)
    # わたってきた値を@orderに入れます
    if @order.save
      cart_items.each do |cart|
        # 取り出したカートアイテムの数繰り返します
# order_item にも一緒にデータを保存する必要があるのでここで保存します
      order_item = OrderItem.new
      order_item.item_id = cart.item_id
      order_item.order_id = @order.id
      order_item.order_quantity = cart.quantity
      # 購入が完了したらカート情報は削除するのでこちらに保存します
        order_item.order_price = cart.item.price
# カート情報を削除するので item との紐付けが切れる前に保存します
      order_item.save
    end
    redirect_to orders_done_path
    cart_items.destroy_all
    # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
    else
    @order = Order.new(order_params)
    render :new
    end
    # if @newaddress.save
    # redirect_to orders_done_path
    # else
    # render :new
    # end
  end



  def done
  end

  private

  def order_params
    params.require(:order).permit(:postcode, :address, :name)
  end
end
