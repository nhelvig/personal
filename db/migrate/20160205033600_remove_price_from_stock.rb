class RemovePriceFromStock < ActiveRecord::Migration
  def change
    remove_column :stocks, :price, :decimal
  end
end
