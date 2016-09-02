namespace :export do
  desc "Prints all database info in a seeds.rb way."
  task :seeds_format => :environment do
    Investment.order(:id).all.each do |investment|
      puts "Investment.create(#{formatInvestment(investment)})"
      end
    Totals.order(:id).all.each do |total|
      puts "Totals.create(#{formatTotal(total)})"
    end
    Transaction.order(:id).all.each do |transaction|
      puts "Transaction.create(#{formatTransaction(transaction)})"
    end
    Holdings.order(:id).all.each do |holding|
      puts "Holdings.create(#{formatHolding(holding)})"
    end
  end

  def formatInvestment(record)
    record = "\"symbol\"=>\"" + record.symbol + 
             "\", \"current_price\"=>" + record.current_price.to_s('F') +
             ", \"avg_cost\"=>" + record.avg_cost.to_s('F') +
             ", \"quantity\"=>" + record.quantity.to_s('F') +
             ", \"total_value\"=>" + record.total_value.to_s('F')
    record
  end

  def formatTotal(record)
    record = "\"date\"=>\'" + record.date.strftime("%d/%m/%Y") + 
             "\', \"percentage_change\"=>" + record.percentage_change.to_s('F') + 
             ", \"total_dividend\"=>" + record.total_dividend.to_s('F') +
             ", \"available_cash\"=>" + record.available_cash.to_s('F') +
             ", \"total_invested\"=>" + record.total_invested.to_s('F') +
             ", \"total_value\"=>" + record.total_value.to_s('F')
    record
  end

  def formatTransaction(record)
    record = "\"date\"=>\'" + record.date.strftime("%d/%m/%Y") + 
             "\', \"symbol\"=>\"" + record.symbol + 
             "\", \"price\"=>" + record.price.to_s('F') +
             ", \"action\"=>\"" + record.action +
             "\", \"quantity\"=>" + record.quantity.to_s('F')
    record
  end

  def formatHolding(record)
    record = "\"date\"=>\'" + record.date.strftime("%d/%m/%Y") + 
             "\', \"symbol\"=>\"" + record.symbol + 
             "\", \"quantity\"=>" + record.quantity.to_s('F') +
             ", \"closing_price\"=>" + record.closing_price.to_s('F')
    record
  end
end