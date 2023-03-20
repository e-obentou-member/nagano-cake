class Menu < ApplicationRecord

  has_one_attached :image

  has_many :cart_items , dependent: :destroy
  has_many :order_details
  belongs_to :genre

  belongs_to :top_page
end
