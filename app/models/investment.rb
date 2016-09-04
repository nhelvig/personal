class Investment < ActiveRecord::Base
  self.primary_key = "symbol"
  @@currentPrices = Hash.new

  def self.build(transaction)
    if transaction.action == 'buy'
      total_value = transaction.price * transaction.quantity
    else
      puts "Trying to sell " + transaction.symbol + " with quantity: " + transaction.quantity.truncate(2).to_s('F') + " at price: $" + transaction.price.truncate(2).to_s('F') + "\n"
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
    update_attribute(:total_value, value)
  end

  def handleSell(investment_value, transaction)
    total_quantity = quantity - transaction.quantity
    update_attribute(:quantity, total_quantity)
    update_attribute(:total_value, value)
    if quantity <= 0
      self.delete
    end
  end

  def get_stock_price
    checkDateForCurrentPrices
    if @@currentPrices.key?(symbol)
      return @@currentPrices[symbol]
    else
      begin
        price = StockQuote::Stock.quote(symbol).last_trade_price_only
      rescue
        price = 10
      end
      @@currentPrices[symbol] = price
    end
    
  end

  def value
    begin
      currentPrice = get_stock_price
      if currentPrice.class == Float
        value = currentPrice * quantity
        if value == nil
          value = "N/A"
        end
        newValue = value.round(2)
        update_attribute(:total_value, value)
        newValue
      end
    rescue
      #not connected to internet
      total_value
    end
  end

  def self.setTotalInvested(amount)
    @@total_invested = amount
  end

  def self.getTotalInvested
    begin
      @@total_invested.round(2)
    rescue
      0
    end
  end

  def self.totalValue
    sum = 0
    Investment.destroy_all("quantity <= 0")
    for investment in Investment.all
      if investment.value != nil
        sum += investment.value
      end
    end
    return (sum + @@available_cash).round(2)
  end

  def self.totalValuePercentage
    if self.getTotalInvested > 0
      return (((self.totalValue/self.getTotalInvested) - 1) * 100).round(2)
    end
    return 0
  end

  def self.setAvailableCash(amount)
    @@available_cash = amount
  end

  def self.getAvailableCash
    @@available_cash.round(2)
  end

  def percent_change
    puts "Symbol - " + symbol.to_s
    (((get_stock_price/avg_cost) - 1) * 100).round(2)
  end

  def checkDateForCurrentPrices
    if @@currentPrices.key?("date")
      if @@currentPrices["date"] != Date.today
        @@currentPrices = Hash.new
        @@currentPrices["date"] = Date.today
      end
    else
      @@currentPrices = Hash.new
      @@currentPrices["date"] = Date.today
    end
  end
end
