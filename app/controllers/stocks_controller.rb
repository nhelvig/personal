class StocksController < ApplicationController
  def index
    @stocks = Stock.all
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      redirect_to @stock
    else
      render 'new'
    end
  end

  def update
    @stock = Stock.find(params[:id])

    if @stock.update(stock_params)
      redirect_to @stock
    else
      render 'edit'
    end
  end

  private
  def stock_params
    params.require(:stock).permit(:symbol, :quantity, :price)
  end
end
