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
    # わたってきた値を@orderに入れます
    if @order.save
      cart_items.each do |cart|
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
    if params[:order][:address_number] == "1"
        # view で定義している address_number が"1"だったときにこの処理を実行します
# form_with で @order で送っているので、order に紐付いた address_number となります。以下同様です
# この辺の紐付けは勉強不足なので gem の pry-byebug を使って確認しながら行いました
    @order.name = current_customer.name
    @order.address = current_customer.customer_address

    # （w）deliveryがないサイトで見ているため、もしかしたら記述が変わるかもしれない

    elsif params[:order][:address_number] == "2"
        # view で定義している address_number が"2"だったときにこの処理を実行します
        if Address.exists?(name: params[:order][:registered])
            # registered は viwe で定義しています
            @order.name = Address.find(params[:order][:registered]).name
            @order.address = Address.find(params[:order][:registered]).address
        else
            render :new
            # 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
        end

    elsif params[:order][:address_number] == "3"

      address_new = current_customer.address.new(address_params)
      if address_new.save # 確定前(確認画面)で save してしまうことになりますが、私の知識の限界でした
      else
      render :new
      #  ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
      end
    else
      redirect_to request.referer
    end
      @cart_items = current_customer.cart_items.all# カートアイテムの情報をユーザーに確認してもらうために使用します
      @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
      # 合計金額を出す処理です sum_price はモデルで定義したメソッドです
  end

    # 分からないからコメントアウトしてます
#     @newaddress = Order.new(order_params)
#     @newaddress.customer_id = current_customer.id
#   end




  def done
  end

  private

  def order_params
    #   合計金額のカラムが入っているらしい？（ｗ）
    params.require(:order).permit(:payment_way, :postcode, :address, :name, :amount)
  end

 def address_params
    params.require(:order).permit(:name, :address)
 end

end
