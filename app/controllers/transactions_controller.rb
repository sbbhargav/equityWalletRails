class TransactionsController < ApplicationController
  before_action :set_stock
	before_action :set_transaction, only: [:show,:edit,:destroy,:update]
	before_action :authorized

	def index
		@transactions = @stock.transactions
	end
  

	def purchased_trans
		@trans = Transaction.purchased_trans(params[:stock_id])
	end

	
	def new
		@transaction = @stock.transactions.build
	end
  
	def create

		@transaction = @stock.transactions.build(transaction_params)

		tot=@transaction.no_of_stocks
		pur_stocks = Transaction.purchased_trans(params[:stock_id])
		sold_stocks = Transaction.sold_trans(params[:stock_id])

		if @transaction.status == "sold"
			if (pur_stocks < (sold_stocks + tot.to_i))
				flash.now[:alert] = "no stocks are less to be sold "
				render :new
			else
				if @transaction.save
					redirect_to stock_transactions_path, notice: "transaction has been created"
				else
					render :new
				end
			end

		else
			if @transaction.save
				redirect_to stock_transactions_path, notice: "transaction has been created"
			else
				render :new
			end
		end

		
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
	
		@transaction.destroy
		redirect_to stock_transactions_path, notice: "deleted successfully"
		
	end

	private
	def set_stock
		@stock = Stock.find(params[:stock_id])
	end
	def set_transaction
		@transaction = @stock.transactions.find(params[:id]) 
	end

	def transaction_params
		params.require(:transaction).permit([:no_of_stocks,:status])
	end

end