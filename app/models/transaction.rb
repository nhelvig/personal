class Transaction < ActiveRecord::Base
  validates :symbol, presence: true

  @@transactions = Hash.new

  def self.recordTransaction(transaction)
    if(@@transactions.has_key?(transaction.symbol))
      @@transactions[transaction.symbol].push(transaction)
    else
      array = []
      @@transactions[transaction.symbol] = array << transaction
    end
  end

  def self.quantity(symbol)
    total = 0
    for transaction in @@transactions[symbol]
      total += transaction.quantity
    end
    total
  end

  def self.allHoldings
    @@transactions
  end

end
