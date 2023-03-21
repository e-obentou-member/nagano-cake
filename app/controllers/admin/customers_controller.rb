class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @id = params[:id]
  end

  def show
    @customers = Customer.all
    @id = params[:id]
  end

  def edit
  end
end
