class Delivery < ApplicationRecord
  belongs_to :customer

  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true

  # DWO参照、public/orders+ブランチで記述(a)
  def address_display
    '〒' + postcode + ' ' + address + ' ' + name
  end

end
