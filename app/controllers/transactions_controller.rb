class TransactionsController < ApplicationController

  logger = Logger.new(STDOUT)

  require 'date'
  def index
    logger.info("Transactions Controller - index")
    # @transactions = Transaction.all
    @investments = Investment.all
    @holdings = Holdings.all
    @totals = Totals.all
    @totalToday = Totals.order('totals.date DESC').first
  end

  def show
    puts "Transactions Controller - show"
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
      if Investment.exists?(@transaction.symbol)
        @investment = Investment.find(@transaction.symbol)
        Holdings.updateQuantityOfStock(@transaction)
      else
        @investment = Investment.build(@transaction)
        if @investment.save
          Holdings.populateHoldings(@transaction)
          Holdings.updateTotals
        else
          raise "NEW INVESTMENT FAILED"
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

  def import
    Transaction.import(params[:file])
    redirect_to investmentTracker_url, notice: "Transactions imported."
  end

  private
  def transaction_params
    params.require(:transaction).permit(:symbol, :quantity, :price, :action, :commission, :date)
  end

end
