class Stock < ApplicationRecord

  belongs_to :user
  has_many :transactions ,dependent: :destroy

  validates :companyname, presence: true, length: { in: 2..50 }, uniqueness: { scope: [:companyname, :user_id] }
  validates :stockprice, presence: true, numericality: { only_integer: true, greater_than: 899, less_than: 10000000 }
  
  scope :total_purchased_amount, -> (s_id) { Stock.find(s_id).stockprice * Transaction.purchased_trans(s_id) }
  scope :total_sold_amount, -> (s_id) { Stock.find(s_id).stockprice * Transaction.sold_trans(s_id) }


  def self.total_purchased_stocks(u_id)
    purchased_stocks=0
    User.find(u_id).stocks.each do |stock|
      purchased_stocks += stock.transactions.purchased_trans(stock.id)
    end
    purchased_stocks
  end

  def self.total_sold_stocks(u_id)
    sold_stocks=0
    User.find(u_id).stocks.each do |stock|
      sold_stocks += stock.transactions.sold_trans(stock.id)
    end
    sold_stocks
  end

  def self.total_invested_amount(u_id)
    invested_amount=0
    User.find(u_id).stocks.each do |stock|
    invested_amount += Stock.total_purchased_amount(stock.id)
    end
    invested_amount
  end

  def self.total_redeemed_amount(u_id)
    redeemed_amount=0
    User.find(u_id).stocks.each do |stock|
    redeemed_amount += Stock.total_sold_amount(stock.id)
    end
    redeemed_amount
  end

end
