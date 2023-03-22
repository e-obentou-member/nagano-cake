class Public::MenusController < ApplicationController
  def index
    @menus = Menu.all
    @menus = Menu.page(params[:page]).per(8)
  end

  def show
    @menu = Menu.find(params[:id])
    @count = params[:count] || 1
    @cart_item = CartItem
  end


end

