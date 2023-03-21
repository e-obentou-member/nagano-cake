class Admin::MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def index
    @menus = Menu.all
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.save!
    redirect_to admin_menus_path
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    @menu.update(menu_params)
    redirect_to adminmenu_path(@menu.id)
  end

  private

  def menu_params
    params.require(:menu).permit(:genre_id, :name, :info,:non_tax_price, :is_sale, :image)
  end

end
