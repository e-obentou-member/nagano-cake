class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new

    # 注文情報入力画面に表示させるのに使う
    # @addresses = Address.all
  end


  # 注文を確定
  def create
    # @order = current_customer.orders.new(params.require(:order).permit(:delivery_date, :payment_way, :address_id))

    cart_items = current_customer.cart_items.all
    # ログインユーザーのカート内商品をすべて取り出す
    @order = current_customer.orders.new(order_params)
    # 引数で取得したカート内商品と支払方法・配送先データ？　がひとつの注文IDとして格納される

    if @order.save

      cart_items.each do |cart_item|
        # cart_itemは商品一種類
        order_detail = OrderDetail.new
        # order_detailインスタンスを生成
        order_detail.menu_id = cart_item.menu_id
        order_detail.order_id = @order.id  #注文ID
        order_detail.count = cart_item.count
        order_detail.tax_in_price = cart_item.menu.tax_in_price
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
    if current_customer
      @orders = current_customer.orders
      # createアクションでDBにsaveしたデータを取得する(a)
    end
  end

  def show
    if current_customer
      @orders = current_customer.orders
      # createアクションでDBにsaveしたデータを取得する(a)
    end
    # @menu = Menu.find(params[:menu_id])
    # @order = @menu.order.new
    @order = Order.find(params[:id])
    @postage = 800  #送料
  end

  def check
    @order = Order.new(order_params)
    @order.payment_way = params[:order][:payment_way]  #支払方法取得

    if params[:order][:address_select] == "1"
    # viewで定義している:addressが"1"だったとき
      @order.name = current_customer.first_name
      @order.address = current_customer.address
      @order.postcode = current_customer.postcode

    elsif params[:order][:address_select] == "2"
    # viewで定義している:addressが"2"だったとき
      # if Delivery.exists?(name: params[:order][:registered])
        # @delivery = Delivery.find(params[:order][:delivery_id])
        # @delivery = Delivery.find(params[:order][:address_display])
        # @delivery = Delivery.find_by(address_display: params[:order][&:address_display])
        # @delivery = Delivery.where("postcode || ' ' || address || ' ' || name LIKE ?", "〒#{params[:order][:address_display]}%").first
        @delivery = Delivery.find(params[:order][:delivery_id])
        # @order.postcode = current_customer.postcode
        # @order.name = Address.find(params[:order][:name]).name
        # @order.address = Address.find(params[:order][:address]).address
      # else
      #   render :new
      # end

      if @delivery
        @order.name = @delivery.name
        @order.address = @delivery.address
        @order.postcode = @delivery.postcode
      end
       # @orderをインスタンス変数として定義
      @payment_way = @order.payment_way
      @postcode = @order.postcode
      @address = @order.address

    elsif params[:order][:address_select] == "3"
      # delivery_new = current_customer.deliveries.new(delivery_params)

      # if delivery_new.save
        # redirectはGETに遷移 注意！
        # redirect_to orders_check_path
      # else
        # render :new
      # end

    else
      redirect_to request.referer
    end

    # @delivery = Delivery.new(delivery_params)
    # @delivery.customer_id = current_customer.id
    # @delivery.save

    @cart_items = current_customer.cart_items.all  #カートアイテムの情報 ユーザー確認用
    @total_price =  @cart_items.sum(&:subtotal_price)  #合計金額
    @postage = 800  #送料
  end


  def done
  end


  private

  def order_params
    #   合計金額のカラムが入っているらしい？（ｗ）
    params.require(:order).permit(:payment_way, :postcode, :address, :name, :amount, :customer_id, :postage)

  end

end
