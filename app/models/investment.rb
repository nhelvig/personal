class Investment < ActiveRecord::Base
  self.primary_key = "symbol"
  @@symbols = {}

  def initialize(transaction)
    symbol = transaction.symbol
    quantity = transaction.quantity
  end

  def addTransaction(transaction)
    investmentValue = transaction.quantity * transaction.price
    if (transaction.action == "buy")
      totalQuantity = transaction.quantity + quantity
      avg_cost = avg_cost * (quantity / totalQuantity) + transaction.price * (transaction.quantity / totalQuantity)
      quantity = totalQuantity
      totalValue += investmentValue
    else

    end


  end

  def get_stock_price
    10.00
  end
end
