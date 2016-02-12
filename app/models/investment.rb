class Investment < ActiveRecord::Base
  self.primary_key = "symbol"
  @@symbols = {}

  def self.build(transaction)
    print "New investment \n"
    investment = Investment.new
    investment.symbol = transaction.symbol
    investment.quantity = transaction.quantity
    investment.total_value = transaction.price * transaction.quantity
    investment.avg_cost = transaction.price
    investment
  end

  def addTransaction(transaction)
    investment_value = transaction.quantity * transaction.price
    if (transaction.action == "buy")
      total_quantity = transaction.quantity + quantity
      print "---------------"
      print avg_cost * (quantity / total_quantity) + transaction.price * (transaction.quantity / total_quantity)
      print "\n"
      print (transaction.quantity / total_quantity)
      print "\n"
      update_attribute(:avg_cost, avg_cost * (quantity / total_quantity) + transaction.price * (transaction.quantity / total_quantity))
      update_attribute(:quantity, total_quantity)
      update_attribute(:total_value, investment_value + total_value)
      save
    end


  end

  def get_stock_price
    10.00
  end
end
