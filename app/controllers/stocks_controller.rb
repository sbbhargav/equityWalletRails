class StocksController < ApplicationController
  before_action :authorized
	before_action :set_stock, only: [:show,:edit,:update,:destroy]

	def index
		@stocks = current_user.stocks.all
	end

	def new
		@stock = current_user.stocks.build
	end

	def create
		@stock = current_user.stocks.build(stock_params)
		if @stock.save
			redirect_to @stock, notice: 'stock created successfully'
		else
			render :new
		end
	end

	def show
		
	end

	def edit
		
	end

	def update
		if @stock.update(stock_params)
			redirect_to @stock ,notice: "updated sucessfully"
		else
			render :edit
		end
	end

	private
  def set_stock
		@stock =Stock.find(params[:id])
	end
	def stock_params
		params.require(:stock).permit([:companyname,:stockprice])
	end
end