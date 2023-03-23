class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :menu

  # 消費税計算(a)
  def tax_in_price
     (self.non_tax_price * 1.1).round
  end

end
