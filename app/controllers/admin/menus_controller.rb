class Admin::MenusController < ApplicationController
  def new
  end

  def index
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :info, :tax_in_price, :non_taxx_price, :is_sale)
  end

end
