class AddSymbolToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :symbol, :string
  end
end
