class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customers = Customer.all
  end
end
