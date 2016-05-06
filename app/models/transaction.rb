class Transaction < ActiveRecord::Base
  require 'csv'
  validates :symbol, presence: true

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      transaction_hash = row.to_hash
      print "Transaction hash: \n"
      print transaction_hash
      print "\n"
      @transaction =Transaction.create!(transaction_hash)
      if Investment.exists?(@transaction.symbol)
        @investment = Investment.find(@transaction.symbol)
        @investment.addTransaction(@transaction)
      else
        @investment = Investment.build(@transaction)
        if @investment.save
          print "Investment saved! \n"
        else
          print "Investment not saved. Error. \n"
        end
      end
      end
  end

end
