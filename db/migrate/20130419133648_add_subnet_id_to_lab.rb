class AddSubnetIdToLab < ActiveRecord::Migration
  def change
  	add_column :labs, :foreman_subnet_id, :integer
  	add_column :labs, :network, :string
  	add_column :labs, :netmask, :string

  end

  def down
  	remove_column :labs, :foreman_subnet_id
  	remove_column :labs, :network
  	remove_column :labs, :netmask
  end
end
