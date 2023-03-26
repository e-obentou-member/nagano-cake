class Public::HomesController < ApplicationController
  def top
    # menus.rbでアソシエーション記述済(a)
    @menus = Menu.order(created_at: :desc)
    @genres = Genre.all
  end

  def about
  end
end
