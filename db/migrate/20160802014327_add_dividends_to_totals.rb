class AddDividendsToTotals < ActiveRecord::Migration
  def change
    add_column :totals, :total_dividend, :decimal
  end
end
