class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new

    # 注文情報入力画面に表示させるのに使う
    # @addresses = Address.all
  end


  # 注文を確定
  def create
    cart_items = current_customer.cart_items.all
    # ログインユーザーのカートアイテムをすべて取り出す
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.menu_id = cart.menu_id
        order_detail.order_id = @order.id
        order_detail.count = cart.count
        order_detail.tax_in_price = cart.menu.tax_in_price
        # カート情報を削除しmenusとの紐付けが切れる前に保存
        order_detail.save
      end
      redirect_to orders_done_path
      cart_items.destroy_all
      # 購入後はカートのデータをすべて削除

    else
      render :new
    end
  end


  def index
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
    # @menu = Menu.find(params[:menu_id])
    # @order = @menu.order.new
  end

  def check
    @order = Order.new(order_params)
    if params[:order][:address_select] == "1"
    # viewで定義している:addressが"1"だったとき
      @order.name = current_customer.name
      @order.address = current_customer.address
      @order.postcode = current_customer.postcode

    elsif params[:order][:address_select] == "2"
    # viewで定義している:addressが"2"だったとき
      # if Delivery.exists?(name: params[:order][:registered])
        @delivery = Delivery.find(params[:order][:delivery_id])
        # @order.postcode = current_customer.postcode
        # @order.name = Address.find(params[:order][:name]).name
        # @order.address = Address.find(params[:order][:address]).address
      # else
      #   render :new
      # end

      @order.name = @delivery.name
      @order.address = @delivery.address
      @order.postcode = @delivery.postcode

    elsif params[:order][:address_select] == "3"
      delivery_new = current_customer.delivery.new(delivery_params)
      if delivery_new.save
        redirect_to orders_check_path
      else
        render :new
      end

    else
      redirect_to request.referer
    end

      @cart_items = current_customer.cart_items.all# カートアイテムの情報をユーザーに確認してもらうために使用します
      @total_price =  @cart_items.sum(&:subtotal_price)
  end


  def done
  end

  private

  def order_params
    #   合計金額のカラムが入っているらしい？（ｗ）
    params.require(:order).permit(:payment_way, :postcode, :address, :name, :amount)
  end

 def delivery_params
    params.require(:order).permit(:name, :address, :postcode)
 end

end
