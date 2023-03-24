class Order < ApplicationRecord
  has_many :order_details , dependent: :destroy
  belongs_to :customer

  # 支払方法
  # クレジットカード→0、credit_card　、銀行振り込み→1,transfer
  enum payment_ways: {credit: 0, bank_transfer: 1}
  # 注文ステータス


  # ymlファイルで日本語
  # 0 = wating_for_payment: "入金待ち"
  # 1 = confirmation_of_payment: "入金確認"
  # 2 = in_production: "製作中"
  # 3 = preparing_to_ship: "発送準備中"
  # 4 = shipped: "発送済み"
  enum order_status: {waiting_payment: 0, confirmation_of_payment: 1, in_production: 2, preparing_to_ship: 3, shipped: 4}

  def payment_way_i18n
    Order.payment_ways_i18n[self.payment_way]
  end

  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true


end
