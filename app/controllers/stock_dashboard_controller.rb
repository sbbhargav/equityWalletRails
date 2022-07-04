class StockDashboardController < ApplicationController

  before_action :authorized
  before_action :set_stocks, only: [:dashboard,:summary,:amount]
  
  def dashboard; end

  def summary; end

  def amount; end

  def total_stocks
    @total_purchased_stocks = Stock.total_purchased_stocks(current_user.id)
    @total_sold_stocks = Stock.total_sold_stocks(current_user.id)
  end

  def total_amount
    @total_invested_amount = Stock.total_invested_amount(current_user.id)
    @total_redeemed_amount = Stock.total_redeemed_amount(current_user.id)
  end

  private 
  def set_stocks
    @all_stocks = current_user.stocks.paginate(page: params[:page], per_page: 3)
  end
  
end
