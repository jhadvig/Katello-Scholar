class CreateRepositoryGroups < ActiveRecord::Migration
  def change
    create_table :repository_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
