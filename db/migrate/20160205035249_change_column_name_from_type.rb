class ChangeColumnNameFromType < ActiveRecord::Migration
  def change
    rename_column :transactions, :type, :action
  end
end
