class Menu < ApplicationRecord

  has_many :cart_items , dependent: :destroy
  has_many :order_details
  belongs_to :genre

  validates :image, presence: true
  validates :name, presence: true
  validates :info, presence: true
  validates :non_tax_price, presence: true
  validates :genre_id, presence: true
  validates :is_sale, presence: true

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


#税込価格k
  def tax_in_price
     (self.non_tax_price * 1.08).round
  end

end
