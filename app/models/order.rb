class Order < ApplicationRecord
  has_many :order_details , dependent: :destroy
  belongs_to :customer

  # 支払方法
  # クレジットカード→0、credit_card　、銀行振り込み→1,transfer
  enum payment_way: {credit: 0, bank_transfer: 1}
  # 注文ステータス
  enum status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}
  
  def payment_way_i18n
    Order.payment_ways_i18n[self.payment_way]
  end

  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true


end
