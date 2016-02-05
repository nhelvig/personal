class RemoveQuantityFromStock < ActiveRecord::Migration
  def change
    remove_column :stocks, :quantity, :decimal
  end
end
