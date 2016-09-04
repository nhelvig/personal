require 'market_beat'

class Holdings < ActiveRecord::Base

  def self.populateHoldings(transaction)
    puts "Getting data..."
    purgeHoldings
    if !Holdings.exists?(:symbol => transaction.symbol, :date => transaction.date)
      begin
        quotes = MarketBeat.quotes(transaction.symbol, transaction.date)
        puts "Data retrieved."
        quotes.reverse_each {|quote|
          puts "Creating new holding..."
          if quote[:date] == transaction.date
            puts "Transaction on date of purchase"
            @holding = Holdings.new(:date => quote[:date], :symbol => transaction.symbol, :quantity => transaction.quantity, :closing_price => transaction.price)
          else
            @holding = Holdings.new(:date => quote[:date], :symbol => transaction.symbol, :quantity => transaction.quantity, :closing_price => quote[:close])
          end
          if @holding.save
            puts "New holding created: " + @holding.to_s
          end
        }
      rescue
        puts "Could not find information for symbol: " + transaction.symbol
    end

    end
  end

  def self.updateAllHoldings
    puts "Updating all holdings"
    mostRecentHolding = Holdings.select("date").order("date DESC").first
    if mostRecentHolding.present?
      Holdings.where("date = :date", date: mostRecentHolding.date).find_each do |holding|
        quotes = MarketBeat.quotes(holding.symbol, holding.date)
        quotes.reverse_each {|quote|
            if !Holdings.exists?(:symbol => holding.symbol, :date => quote[:date])
              puts "Creating new holding..."
              @holding = Holdings.new(:date => quote[:date], :symbol => holding.symbol, :quantity => holding.quantity, :closing_price => quote[:close])
              if @holding.save
                puts "New holding created: " + @holding.to_s
              end
            end
        }
      end
      puts "All holdings updated."
    else
      puts "No holdings to update."
    end
  end


  def self.updateQuantityOfStock(transaction)
    puts "Updating quantities of holdings."
    puts "Getting all holdings after " + transaction.date.to_s
    if transaction.action == "buy"
      Holdings.where("symbol = :symbol AND date >= :date", symbol: transaction.symbol, date: transaction.date).update_all("quantity = quantity + #{transaction.quantity}")
    else
      Holdings.where("symbol = :symbol AND date >= :date", symbol: transaction.symbol, date: transaction.date).update_all("quantity = quantity - #{transaction.quantity}")
    end
  end

  def self.updateTotals
    purgeHoldings
    puts "Updating totals..."
    date = Holdings.minimum(:date)
    availableCash = 0
    totalInvested = 0
    totalDividend = 0
    while date <= Date.today
      totalValue = BigDecimal.new("0")
      Holdings.where("date = :date", date: date).find_each do |holding|
        totalValue = totalValue + (holding.closing_price * holding.quantity)
      end
      Transaction.where("date = :date", date: date).find_each do |transaction|
        transactionValue = transaction.price * transaction.quantity
        if transaction.action == 'buy'
          if transactionIsDividend(transaction) && !specialCaseForARR(transaction)
              totalDividend = totalDividend + transactionValue
          else
            availableCash, totalInvested = updateAvailableCashAndTotalInvested(availableCash, totalInvested, transactionValue)
          end
        else
          availableCash = availableCash + transactionValue
        end
      end
      puts "Total value at end: " + totalValue.to_s
      if Totals.where(:date => date).exists?
        puts "Total for " + date.to_s + " already exists. Total value is now: " + totalValue.to_s
        row = Totals.where("date = :date", date: date).first
        puts "The row is: " + row.to_s
        row.total_value = totalValue + availableCash
        row.total_invested = totalInvested
        row.available_cash = availableCash
        row.total_dividend = totalDividend
        row.percentage_change = getPercentageChange(totalInvested, totalValue + availableCash)
        if row.save
          puts "Total value for " + date.to_s + " updated to: " + totalValue.to_s
          puts "Updating date in the middle."
          date = date.next_day
        else
          puts "Error saving new total value for " + date.to_s
        end
      else if totalValue.nonzero?
        puts "Making new total for " + date.to_s + " with value: " + totalValue.to_s
        percentage_change = Holdings.getPercentageChange(totalInvested, totalValue + availableCash)
        total = Totals.new(:date => date, :total_value => totalValue + availableCash, :total_invested => totalInvested, :available_cash => availableCash, :total_dividend => totalDividend, :percentage_change => percentage_change)
        if total.save
          puts "New total saved."
        end
      end
      puts "Updating date at the end because totalValue = " + totalValue.to_s
      date = date.next_day
      end
    end
  end

  def self.purgeHoldings
    puts "Purging Holdings table..."
    Holdings.destroy_all("quantity <= 0")
    puts "Holdings table purged."
  end

  def self.updateAvailableCashAndTotalInvested(availableCash, totalInvested, transactionValue)
    cashNeededForInvestment = transactionValue - availableCash
    if cashNeededForInvestment >= 0
      totalInvested = totalInvested + cashNeededForInvestment
    end
    availableCash = availableCash - transactionValue
    if  availableCash < 0
      availableCash = 0
    end
    return availableCash, totalInvested
  end

  def self.specialCaseForARR(transaction)
    transaction.symbol == 'ARR' && transaction.quantity > 1
  end

  def self.transactionIsDividend(transaction)
    transaction.quantity % 1 != 0
  end

  def self.getPercentageChange(totalInvested, totalValue)
    if totalInvested > 0
      return (((totalValue/totalInvested) - 1) * 100).round(2)
    end
    return 0
  end

end
