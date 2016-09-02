class AddTotalsTable < ActiveRecord::Migration
  create_table :totals do |t|
    t.date :date, :null => false
    t.decimal :total_value, :null => false
  end
end
