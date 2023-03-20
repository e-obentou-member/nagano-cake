class Public::MenusController < ApplicationController
  def index
    # @menus = Menu.all
    # @menus = Menu.page(params[:page]).per(8)
  end

  def show
    # @menu = Menu.find(params[:id])
    @quantity = params[:quantity] || 1
  end
end
