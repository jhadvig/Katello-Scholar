class AddStatusToRepository < ActiveRecord::Migration
  def change
  	add_column :repositories, :status, :bool
  end

  def down
  	remove_column :repositories
  end
end
