class Transaction < ApplicationRecord

  enum :status , { purchased: 0, sold: 1}

  belongs_to :stock

  validates :status, presence: true
  validates :no_of_stocks, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10001 }
  validate :has_enough_stocks?, on: :create
  validate :has_enough_stocks_to_update?, on: :update
  
  scope :purchased_trans, -> (s_id) { where(status: "purchased",stock_id: s_id).sum(:no_of_stocks)}
  scope :sold_trans, -> (s_id) { where(status: "sold",stock_id: s_id).sum(:no_of_stocks)}

  before_destroy :has_enough_purchased_stocks

  def has_enough_stocks?
    if status == "sold" and purchased_stocks < (sold_stocks + no_of_stocks)
      errors.add(:status, message: "purchased stocks are less to sold")
    else
      true
    end
  end

  def check(p1,p2)
    if p1 >= p2
      true
    else
      errors.add(:status, message: "can't purchase sold stocks can't be more")
    end
  end

  def has_enough_stocks_to_update?
    past_status = Transaction.find_by(id: id).status
    past_stocks = Transaction.find_by(id: id).no_of_stocks
    if status == "purchased" and past_status == "sold"
      after_pur = purchased_stocks + no_of_stocks
      remain_sold = sold_stocks - past_stocks
      check(after_pur,remain_sold)
    elsif status == "sold" and past_status == "purchased"
      after_sold = sold_stocks + no_of_stocks
      remain_pur = purchased_stocks - past_stocks
      check(remain_pur,after_sold)
    elsif status == "purchased" and past_status == "purchased"
      after_pur = (purchased_stocks - past_stocks) + no_of_stocks
      check(after_pur,sold_stocks)
    else
      after_sold = (sold_stocks - past_stocks) + no_of_stocks
      check(purchased_stocks,after_sold)
    end
  end

  def has_enough_purchased_stocks
    if status == "purchased" and (purchased_stocks - no_of_stocks) < sold_stocks
      errors.add(:status, message: "can't be deleted") 
      throw(:abort)
    end
  end

  def purchased_stocks
    Transaction.purchased_trans(stock_id)
  end

  def sold_stocks
    Transaction.sold_trans(stock_id)
  end

end


