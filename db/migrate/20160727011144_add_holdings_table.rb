class AddHoldingsTable < ActiveRecord::Migration
  create_table :holdings do |t|
    t.date :date, :null => false
    t.string :symbol, :null => false
    t.decimal :quantity, :null => false
    t.decimal :closing_price, :null => false
  end
end
