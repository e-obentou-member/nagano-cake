class Public::HomesController < ApplicationController
  def top
    # menus.rbでアソシエーション記述済(a)
    @manus = Menu.order(created_at: :desc)
    @genres = Menu.genre_id
  end

  def about
  end
end
