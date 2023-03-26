class Public::OrdersController < ApplicationController

  def new
    @customer = current_customer
    @order = Order.new
  end

  def check
    @order = Order.new(order_params)   #2. new.htmlで貰った情報を取得し変数@orderを生成
    @order.payment_way = params[:order][:payment_way]  #支払方法取得

    #3. address_selectに合わせた配送先情報を@orderに格納
    if params[:order][:address_select] == "1"
      # new.htmlで1を選んだ場合はcustmerに紐づく名前/住所/〒を取得し左辺変数に格納
      @order.name = current_customer.first_name
      @order.address = current_customer.address
      @order.postcode = current_customer.postcode

    elsif params[:order][:address_select] == "2"
      # new.htmlで1を選んだ場合はDeliveryモデルからdelivery_idを取得
      # delivery_idはnew.html.erb30行目で定義済
      # 30行目で定義されているaddress_displayはDeliveryモデルで定義済
      @delivery = Delivery.find(params[:order][:delivery_id])

      # @order.postcode = current_customer.postcode
      # @order.name = Address.find(params[:order][:name]).name
      # @order.address = Address.find(params[:order][:address]).address

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
      # form_withで値を取得
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

    @cart_items = current_customer.cart_items.all  #カートアイテムの情報 ユーザー確認用
    @total_price =  @cart_items.sum(&:subtotal_price)  #合計金額
    @postage = 800  #送料
  end


  def create
    # @order = current_customer.orders.new(params.require(:order).permit(:delivery_date, :payment_way, :address_id))

    cart_items = current_customer.cart_items.all
    # ログインユーザーのカート内商品をすべて取り出す
    @order = current_customer.orders.new(order_params)
    # 6．5で入れ直した注文情報をひとつの注文IDとして新しく生成、@ordersとする

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
      @customer = current_customer
      @order = Order.new
      render :new

    end
  end

  def done
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



  private

  def order_params
    #   合計金額のカラムが入っているらしい？（ｗ）
    params.require(:order).permit(:payment_way, :postcode, :address, :name, :amount, :customer_id, :postage)

  end

end
