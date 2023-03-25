class Genre < ApplicationRecord
  has_many :menus
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
