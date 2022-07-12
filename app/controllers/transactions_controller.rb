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
      flash[:success] = 'transaction has been created'
      redirect_to stock_transactions_path
    else
      render :new
    end
  end

  def show; end

  def edit;	end

  def update
    if @transaction.update(transaction_params)
      flash[:success] = "updated successfully"
      redirect_to [@stock,@transaction]
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    if @transaction.errors.any?
      flash[:danger] = "can't delete purchased stocks can't be less than sold stocks"
      redirect_to stock_transactions_path
    else
      flash[:success] = "deleted successfully"
      redirect_to stock_transactions_path
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