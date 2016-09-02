class Transaction < ActiveRecord::Base
  require 'csv'
  validates :symbol, presence: true

  def self.import(file)
    beginning_time = Time.now
    CSV.foreach(file.path, headers: true) do |row|

      transaction_hash = row.to_hash
      print "Transaction hash: \n"
      print transaction_hash
      print "\n"
      @transaction =Transaction.create!(transaction_hash)
      if Investment.where(:symbol => @transaction.symbol).exists?
        @investment = Investment.find(@transaction.symbol)
        @investment.addTransaction(@transaction)
        Holdings.updateQuantityOfStock(@transaction)
      else
        @investment = Investment.build(@transaction)
        if @investment.save
          Holdings.populateHoldings(@transaction)
          print "Investment saved! \n"
        else
          print "Investment not saved. Error. \n"
        end
      end
    end
    Holdings.updateTotals
    end_time = Time.now
    puts "Time elapsed #{(end_time - beginning_time)} seconds"
  end

end
