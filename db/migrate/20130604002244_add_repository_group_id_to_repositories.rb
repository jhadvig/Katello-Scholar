class AddRepositoryGroupIdToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :repository_group_id, :integer
  end

  def down
    remove_column :repositories, :repository_group_id
  end
end
