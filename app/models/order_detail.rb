class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :menu
  
  enum make_status: {
    not_startable: 0,
    wating_for_production: 1,
    under_production: 2,
    production_completed: 3
}
  
end
