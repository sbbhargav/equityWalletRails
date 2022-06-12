class StockDashboardController < ApplicationController
	before_action :authorized
	before_action :set_stocks, only: [:dashboard,:summary,:amount]
	def index
	end
	
	def dashboard
		
	end

	def summary
		
	end

	def amount
		
	end

	def total_stocks
		@total_purchased_stocks = Stock.total_purchased_stocks(current_user.id)
		@total_sold_stocks = Stock.total_sold_stocks(current_user.id)
		# @all_stocks = current_user.stocks
		# @total_purchased_stocks=0
		# @total_sold_stocks=0
		# @all_stocks.each do |stock|
		# 	@total_purchased_stocks+=stock.transactions.purchased_trans(stock.id)
		# 	@total_sold_stocks+=stock.transactions.sold_trans(stock.id)
		# end
	end

	def total_amount
		@total_invested_amount = Stock.total_invested_amount(current_user.id)
		@total_redeemed_amount = Stock.total_redeemed_amount(current_user.id)
		# @all_stocks = current_user.stocks
		# @total_invested_amount=0
		# @total_redeemed_amount=0
		# @all_stocks.each do |stock|
		# 	@total_invested_amount+=(stock.transactions.purchased_trans(stock.id)*stock.stockprice)
		# 	@total_redeemed_amount+=(stock.transactions.sold_trans(stock.id)*stock.stockprice)
		# end
	end

	private 
	def set_stocks
		@all_stocks = current_user.stocks
	end
end
