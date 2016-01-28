class ChangeDatatypeForStock < ActiveRecord::Migration
  def change
    change_column :stocks, :quantity,  :decimal
    change_column :stocks, :price,  :decimal
  end
end
