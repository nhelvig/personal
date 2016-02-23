class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
    @investments = Investment.all
  end

  def show
    @transaction = Transaction.find(params[:id])
    begin
      @investment = Investment.find(@transaction.symbol)
    rescue ActiveRecord::RecordNotFound
      @investment = Investment.new(@transaction)
      @investment.save
    end
  end

  def new
    @transaction = Transaction.new

  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save

      if Investment.contains(@transaction.symbol)
        @investment = Investment.find(@transaction.symbol)
        @investment.addTransaction(@transaction)
      else
        @investment = Investment.build(@transaction)
        if @investment.save
          print "good"
          # Investment.symbols.add(@transaction.symbol)
        end
      end
      redirect_to transactions_path
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
