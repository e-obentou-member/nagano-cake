class Admin::MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def index
    @menus = Menu.all
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.save
    redirect_to menu_path
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    @menu.update
    redirect_to menu_path(@menu.id)
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :info, :tax_in_price, :non_taxx_price, :is_sale)
  end

end
