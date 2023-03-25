class Genre < ApplicationRecord
  has_many :menus
  
  validates :name, presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
