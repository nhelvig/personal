class AddTotalInvestedAndAvailableCashToTotals < ActiveRecord::Migration
  def change
    add_column :totals, :total_invested, :decimal
    add_column :totals, :available_cash, :decimal
  end
end
