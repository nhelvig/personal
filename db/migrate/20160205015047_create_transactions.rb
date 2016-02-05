class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :stock_id
      t.decimal :price
      t.string :type
      t.decimal :quantity
      t.decimal :commission

      t.timestamps null: false
    end
  end
end
