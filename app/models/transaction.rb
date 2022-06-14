class Transaction < ApplicationRecord

  belongs_to :stock

  enum :status , { purchased: 0, sold: 1}
  validates :no_of_stocks, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10001 }

  validates :status, presence: true
  scope :purchased_trans, -> (s_id) { where(status: "purchased",stock_id: s_id).sum(:no_of_stocks)}

  scope :sold_trans, -> (s_id) { where(status: "sold",stock_id: s_id).sum(:no_of_stocks)}

  # def has_enough_stocks?
  #   if status == "sold"
  #     Transaction.purchased_trans(stock_id) >= Transaction.sold_trans(stock_id)+no_of_stocks
  #   else
  #     true
  #   end
  # end

end
