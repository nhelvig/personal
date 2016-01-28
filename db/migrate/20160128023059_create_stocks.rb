class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.integer :price

      t.timestamps null: false
    end
  end
end
