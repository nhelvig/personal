class Investment < ActiveRecord::Base
  self.primary_key = "symbol"
  @@symbols = []
  @@total_invested
  @@net_amount

  def self.build(transaction)
    print "New investment \n"
    investment = Investment.new
    investment.symbol = transaction.symbol
    investment.quantity = transaction.quantity
    investment.total_value = transaction.price * transaction.quantity
    investment.avg_cost = transaction.price
    investment.current_price = transaction.price
    investment
  end

  def addTransaction(transaction)
    investment_value = transaction.quantity * transaction.price
    if transaction.action == 'buy'
      total_quantity = quantity + transaction.quantity
      new_avg_cost = avg_cost * (quantity / total_quantity) + transaction.price * (transaction.quantity / total_quantity)
      update_attribute(:avg_cost, new_avg_cost)
      update_attribute(:quantity, total_quantity)
      update_attribute(:total_value, investment_value + total_value)
      save
    elsif transaction.action == 'sell'
      total_quantity = quantity - transaction.quantity
      update_attribute(:quantity, total_quantity)
      update_attribute(:total_value, total_value - investment_value)
    else
      print "This is not right"
      # throw new error ("action not a buy or sell")
    end

  end

  def get_stock_price
    StockQuote::Stock.quote(symbol).ask
  end

  def value
    if StockQuote::Stock.quote(symbol).ask.class == Float
      StockQuote::Stock.quote(symbol).ask * quantity
    end

  end

  def self.totalInvestmentValue
    sum = 1000
    # for Investment.all do investment|
    #    sum += investment.total_value
    # end
    sum
    # return map(Investment.all)
  end

end
