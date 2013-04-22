class AddHostgroupIdToLessons < ActiveRecord::Migration
  def change
  	add_column :lessons, :foreman_hostgroup_id, :integer
  end

  def down
  	remove_column :lessons, :foreman_hostgroup_id
  end

end
