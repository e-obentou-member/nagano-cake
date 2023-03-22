class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :menu

  # 小計計算
  def subtotal
    price * quantity
  end

end
