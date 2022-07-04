class Transaction < ApplicationRecord

  enum :status , { purchased: 0, sold: 1}

  belongs_to :stock

  validates :status, presence: true
  validates :no_of_stocks, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10001 }
  validate :has_enough_stocks?, on: [:create,:update]
  
  scope :purchased_trans, -> (s_id) { where(status: "purchased",stock_id: s_id).sum(:no_of_stocks)}
  scope :sold_trans, -> (s_id) { where(status: "sold",stock_id: s_id).sum(:no_of_stocks)}

  before_destroy :has_enough_purchased_stocks

  def has_enough_stocks?
    if status == "sold" and Transaction.purchased_trans(stock_id) < (Transaction.sold_trans(stock_id)+no_of_stocks)
      errors.add(:status, message: "stocks are less to sold")
    else
      true
    end
  end

  def has_enough_purchased_stocks
    if status == "purchased" and Transaction.sold_trans(stock_id) > (Transaction.purchased_trans(stock_id)-no_of_stocks)
      errors.add(:status, message: "can't be deleted") 
      throw(:abort)
    end
  end
  
end


