class AddSymbolToInvestment < ActiveRecord::Migration
  def change
    add_column :investments, :symbol, :string
    add_column :investments, :avg_cost, :decimal
    add_column :investments, :current_price, :decimal
    add_column :investments, :total_value, :decimal
    add_column :investments, :quantity, :decimal
  end
end
