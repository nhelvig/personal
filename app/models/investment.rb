class Investment < ActiveRecord::Base
  self.primary_key = "symbol"
  @@symbols = []
  @@total_invested = 0
  @@available_cash = 0

  def self.build(transaction)
    print "New investment \n"
    if transaction.action == 'buy'
      total_value = transaction.price * transaction.quantity
      @@total_invested += total_value
    else
      # print "Cannot sell something that is not owned"
    end
    investment = Investment.new
    investment.symbol = transaction.symbol
    investment.quantity = transaction.quantity
    investment.total_value = total_value
    investment.avg_cost = transaction.price
    investment.current_price = transaction.price
    investment
  end

  def addTransaction(transaction)
    investment_value = transaction.quantity * transaction.price
    if transaction.action == 'buy'
      total_quantity = quantity + transaction.quantity
      new_avg_cost = (avg_cost * (quantity / total_quantity) + transaction.price * (transaction.quantity / total_quantity)).round(2)
      update_attribute(:avg_cost, new_avg_cost)
      update_attribute(:quantity, total_quantity)
      update_attribute(:total_value, investment_value + total_value)
      updateTotalInvested(investment_value)
      updateAvailableCash(investment_value)
      print "total_invested: "
      print @@total_invested
      save
    elsif transaction.action == 'sell'
      total_quantity = quantity - transaction.quantity
      update_attribute(:quantity, total_quantity)
      update_attribute(:total_value, total_value - investment_value)
      @@available_cash += investment_value
    else
      print "This is not right"
      # throw new error ("action not a buy or sell")
    end

  end

  def updateAvailableCash(investment_value)
    @@available_cash = @@available_cash - investment_value
    if @@available_cash < 0
      @@available_cash = 0
    end
  end

  def updateTotalInvested(investment_value)
    print "updateTotalInvested \n"
    print "investment_value: \n"
    print investment_value
    print "\n"
    print "available_cash: \n"
    print @@available_cash
    print "\n"
    print "total_invested: \n"
    print @@total_invested
    print "--------------\n"
    if investment_value - @@available_cash > 0
      @@total_invested = @@total_invested + investment_value - @@available_cash
    end
    print "total_invested: \n"
    print @@total_invested
    print "\n"
  end

  def get_stock_price
    begin
      StockQuote::Stock.quote(symbol).ask
    rescue
      #not connected to internet
      10
    end
  end

  def value
    begin
      if StockQuote::Stock.quote(symbol).ask.class == Float
        StockQuote::Stock.quote(symbol).ask * quantity
      end
    rescue
      #not connected to internet
      25
    end
  end

  def self.totalInvested
    begin
      @@total_invested
    rescue
      0
    end
  end

  def self.totalValue
    sum = 0

    for investment in Investment.all
       sum += investment.value
    end
    print "SUM: \n"
    print sum
    return sum + @@available_cash
  end

  def self.availableCash
    @@available_cash
  end

end
