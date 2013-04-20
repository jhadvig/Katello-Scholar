class AddOperatingSystemIdToTemplates < ActiveRecord::Migration
  def change
  	add_column :templates, :operating_system_id, :integer
  end

  def down
  	remove_column :templates, :operating_system_id
  end
end
