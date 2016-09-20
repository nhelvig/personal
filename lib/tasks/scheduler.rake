desc "This task will be called as a scheduled chron job"
task :update_stock_info => :environment do
  puts "Updating stock info..."
  Holdings.updateAllHoldings
  Holdings.updateTotals
  puts "done."
end