class AddFullNameToOperatingSystem < ActiveRecord::Migration
  def change
  	add_column :operating_systems, :full_name, :string
  end

  def down
  	remove_column :operating_systems, :full_name
  end
end
