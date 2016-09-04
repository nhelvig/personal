class AddIndexesToTables < ActiveRecord::Migration
  def change
  	change_table :holdings do |t|
	  t.index :date
	end
	change_table :transactions do |t|
	  t.index :date
	end
	change_table :totals do |t|
	  t.index :date
	end
  end
end
