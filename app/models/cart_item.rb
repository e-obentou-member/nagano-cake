class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :menu


  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # 消費税計算(a)
  def tax_in_price
     (self.non_tax_price * 1.1).round
  end

end
