class Admin::MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def index
    @menus = Menu.all.page(params[:page]).per(1)
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
     redirect_to admin_menus_path(@menu.id)
     flash[:notice] = "Menu was successfully created."
    else
      @menus = Menu.all
      render:index
    end
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
     redirect_to admin_menu_path(@menu.id)
     flash[:notice] = "Menu was successfully destroyed."
    else
      render:edit
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:genre_id, :name, :info,:non_tax_price, :is_sale, :image)
  end

end
