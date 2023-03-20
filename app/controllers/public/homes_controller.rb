class Public::HomesController < ApplicationController
  def top
    # menus.rbでアソシエーション記述済
    # @manus = Menu.order(created_at: :desc)
  end

  def about
  end
end
