class AddPercentageChangeToTotals < ActiveRecord::Migration
  def change
    add_column :totals, :percentage_change, :decimal
  end
end
