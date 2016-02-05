class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
    @investments = Transaction.allHoldings
  end

  def show
    @transaction = Transaction.find(params[:id])
    @stock = Stock.find(@transaction.symbol)
  end

  def new
    @transaction = Transaction.new

  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      @stock = Stock.new({:symbol => @transaction.symbol})
      @stock.save
      Transaction.recordTransaction(@transaction)
      redirect_to @transaction
    else
      render 'new'
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to @transaction
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    redirect_to transactions_path
  end

  private
  def transaction_params
    params.require(:transaction).permit(:symbol, :quantity, :price, :action, :commission)
  end

end
