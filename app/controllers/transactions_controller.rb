class TransactionsController < ApplicationController

  before_action :set_stock
  before_action :set_transaction, only: [:show,:edit,:destroy,:update]
  before_action :authorized
  
  def index
    @transactions = @stock.transactions.paginate(page: params[:page], per_page: 4)
  end

  def new
    @transaction = @stock.transactions.build
  end
  
  def create
    @transaction = @stock.transactions.build(transaction_params)
    if @transaction.save
        redirect_to stock_transactions_path, notice: "transaction has been created"
    else
      render :new
    end
  end

  def show; end

  def edit;	end

  def update
    if @transaction.update(transaction_params)
      redirect_to [@stock,@transaction],notice: "updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    if @transaction.errors.any?
      redirect_to stock_transactions_path, notice: "can't delete purchased stocks can't be less than sold stocks"
    else
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

  def transaction_params
    params.require(:transaction).permit([:no_of_stocks,:status])
  end

end