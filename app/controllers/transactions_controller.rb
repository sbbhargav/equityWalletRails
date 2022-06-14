class TransactionsController < ApplicationController

include TransactionsConcern
  before_action :set_stock
	before_action :set_transaction, only: [:show,:edit,:destroy,:update]
	before_action :authorized
	before_action :set_stock_summary

	def index
		@transactions = @stock.transactions.paginate(page: params[:page], per_page: 4)
	end
  

	def purchased_trans
		@trans = Transaction.purchased_trans(params[:stock_id])
	end

	
	def new
		@transaction = @stock.transactions.build
	end
  
	def create

		@transaction = @stock.transactions.build(transaction_params)
    
    if enough_stocks(params[:stock_id],@transaction)
			if @transaction.save
				redirect_to stock_transactions_path, notice: "transaction has been created"
			else
				render :new
			end
		else
			flash.now[:alert] = "no stocks are less to be sold "
			render :new
		end


		# tot=@transaction.no_of_stocks
		
		# if @transaction.status == "sold"
		# 	if (@pur_stocks < (@sold_stocks + tot.to_i))
		# 		flash.now[:alert] = "no stocks are less to be sold "
		# 		render :new
		# 	else
		# 		if @transaction.save
		# 			redirect_to stock_transactions_path, notice: "transaction has been created"
		# 		else
		# 			render :new
		# 		end
		# 	end

		# else
		# 	if @transaction.save
		# 		redirect_to stock_transactions_path, notice: "transaction has been created"
		# 	else
		# 		render :new
		# 	end
		# end
	
	end

	def show
	end

	def edit
		
	end

	def update
		
		if @transaction.update(transaction_params)
			redirect_to [@stock,@transaction],notice: "updated successfully"
		else
			render :edit
		end

	end

	def destroy
		
    if @transaction.status == "purchased"
			if @sold_stocks > (@pur_stocks-@transaction.no_of_stocks)
				redirect_to stock_transactions_path, notice: "sold stocks are more than purchased stocks"
			else
				@transaction.destroy
				redirect_to stock_transactions_path, notice: "deleted successfully"
			end
		else
			@transaction.destroy
			redirect_to stock_transactions_path, notice: "deleted successfully"
		end
		
	end

	private
	def set_stock
		@stock = Stock.find(params[:stock_id])
	end
	def set_transaction
		@transaction = @stock.transactions.find(params[:id]) 
	end

	def set_stock_summary
		@pur_stocks = Transaction.purchased_trans(params[:stock_id])
		@sold_stocks = Transaction.sold_trans(params[:stock_id])
	end

	def transaction_params
		params.require(:transaction).permit([:no_of_stocks,:status])
	end

end