class Transaction < ApplicationRecord

  belongs_to :stock

  enum :status , { purchased: 0, sold: 1}

  validates :status, presence: true
  validates :no_of_stocks, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10001 }

  scope :purchased_trans, -> (s_id) { where(status: "purchased",stock_id: s_id).sum(:no_of_stocks)}

  scope :sold_trans, -> (s_id) { where(status: "sold",stock_id: s_id).sum(:no_of_stocks)}

  validate :has_enough_stocks?, on: :create

  before_destroy :has_more_sold_stocks

  validate :has_more_sold_stocks?, on: :destroy

  def has_enough_stocks?
    if status == "sold" and Transaction.purchased_trans(stock_id) < (Transaction.sold_trans(stock_id)+no_of_stocks)
      errors.add(:status, message: "stocks are less to sold")
    else
      true
    end
  end

  def has_more_sold_stocks
    if status == "purchased" and Transaction.sold_trans(stock_id) > (Transaction.purchased_trans(stock_id)-no_of_stocks)
      errors.add(:status, message: "can't be deleted") 
      throw(:abort)
    end
    
  end

  
end


