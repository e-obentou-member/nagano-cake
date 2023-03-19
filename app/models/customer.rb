class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :cart_items , dependent: :destroy
  has_many :deliveries , dependent: :destroy
  
    # include JpPrefecture
  # jp_prefecture :address
  
  def prefecture_name
     JpPrefecture::Prefecture.find(code: address).try(:name)
  end   
  
 def prefecture_name=(prefecture_name)
     self.address = JpPrefecture::Prefecture.find(name: prefecture_name).code
 end 
  
end
