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
      raise 'Cannot sell something that is not owned'
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
      handleBuy(investment_value, transaction)
      save
    elsif transaction.action == 'sell'
      handleSell(investment_value, transaction)
    else
      raise 'The transaction is somehow not a buy or a sell'
    end

  end

  def handleBuy(investment_value, transaction)
    total_quantity = quantity + transaction.quantity
    new_avg_cost = (avg_cost * (quantity / total_quantity) + transaction.price * (transaction.quantity / total_quantity)).round(2)
    update_attribute(:avg_cost, new_avg_cost)
    update_attribute(:quantity, total_quantity)
    update_attribute(:total_value, investment_value + total_value)
    updateTotalInvested(investment_value)
    updateAvailableCash(investment_value)
  end

  def handleSell(investment_value, transaction)
    total_quantity = quantity - transaction.quantity
    update_attribute(:quantity, total_quantity)
    update_attribute(:total_value, total_value - investment_value)
    @@available_cash += investment_value
    if quantity <= 0
      self.delete
    end
  end

  def updateAvailableCash(investment_value)
    @@available_cash = @@available_cash - investment_value
    if @@available_cash < 0
      @@available_cash = 0
    end
  end

  def updateTotalInvested(investment_value)
    if investment_value - @@available_cash > 0
      @@total_invested = @@total_invested + investment_value - @@available_cash
    end
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
        value = StockQuote::Stock.quote(symbol).ask * quantity
        if value == nil
          value = "N/A"
        end
        value.round(2)
      end
    rescue
      #not connected to internet
      25
    end
  end

  def self.totalInvested
    begin
      @@total_invested.round(2)
    rescue
      0
    end
  end

  def self.totalValue
    sum = 0
    for investment in Investment.all
      if investment.value != nil
        sum += investment.value
      end

    end
    return (sum + @@available_cash).round(2)
  end

  def self.totalValuePercentage
    if self.totalInvested > 0
      return (((self.totalValue/self.totalInvested) - 1) * 100).round(2)
    end
    return 0
  end

  def self.availableCash
    @@available_cash.round(2)
  end

end
