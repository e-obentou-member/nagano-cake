class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!


  def index
    # @cart_items = current_customer.cart_items.all
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)

    #会員のcart_itemテーブル内に(元々)同じ商品がある場合、数量を追加し更新・保存する(a)
    # menu_idはカートに入ったmenusテーブルの1レコードを表す(a)
    if current_customer.cart_items.find_by(menu_id: params[:cart_item][:menu_id]).present?
      cart_item = current_customer.cart_items.find_by(menu_id: params[:cart_item][:menu_id])
      cart_item.count += params[:cart_item][:count].to_i
     #cart_item.quantityに今追加したparams[:cart_item][:quantity]を加える、to_iで数字指定(a)
      cart_item.save
      redirect_to cart_items_path

    # もしカート内に「同じ」商品がない場合は通常の保存処理(a)
    elsif @cart_item.save
    　@cart_items = current_customer.cart_items.all
    　render 'index'
    else　# 保存できなかった場合(a)
      render 'index'
    end
  end

  def update
  end



  def destroy_all
  end

private
  def cart_item_params
      params.require(:cart_item).permit(:menu_id, :price, :count)
  end

end
