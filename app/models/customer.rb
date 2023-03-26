class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :cart_items , dependent: :destroy
  has_many :deliveries , dependent: :destroy


  validates :first_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name, presence: true
  validates :last_name_kana, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

# is_deleteがfalseならtrueを返すようにしている
def active_for_authentication?
  super && (is_delete == false)
end

    # include JpPrefecture
  # jp_prefecture :address

  def prefecture_name
     JpPrefecture::Prefecture.find(code: address).try(:name)
  end

 def prefecture_name=(prefecture_name)
     self.address = JpPrefecture::Prefecture.find(name: prefecture_name).code
 end

end
