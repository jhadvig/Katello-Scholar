class AddForemanResourceIdToSystemHost < ActiveRecord::Migration
  def change
  	add_column :system_hosts, :foreman_resource_id, :integer
  end

  def down
  	remove_column :system_hosts, :foreman_resource_id  	
  end
end
