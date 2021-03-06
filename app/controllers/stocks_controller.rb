class StocksController < ApplicationController

  before_action :authorized
  before_action :set_stock, only: [:show,:edit,:update,:destroy]

  def index
    @stocks = current_user.stocks.all.paginate(page: params[:page], per_page: 4)
  end

  def new
    @stock = current_user.stocks.build
  end

  def create
    @stock = current_user.stocks.build(stock_params)
    if @stock.save
      flash[:success] = 'stock created successfully'
      redirect_to @stock
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @stock.update(stock_params)
      flash[:success] = "updated sucessfully"
      redirect_to @stock
    else
      render :edit
    end
  end

  def destroy
    @stock.destroy
    flash[:success] = "deleted successfully"
    redirect_to stocks_path
  end

  private
  def set_stock
    @stock =Stock.find(params[:id])
  end
  
  def stock_params
    params.require(:stock).permit([:companyname,:stockprice])
  end

end