class DropStocksTable < ActiveRecord::Migration
  def up
    drop_table :stocks
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end