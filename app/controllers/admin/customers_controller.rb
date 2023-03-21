class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @id = params[:id]
  end

  def show
  end

  def edit
  end
end
