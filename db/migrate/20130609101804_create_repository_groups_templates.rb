class CreateRepositoryGroupsTemplates < ActiveRecord::Migration
  def up
    create_table :repository_groups_templates, :id => false do |t|
      t.integer :repository_group_id
      t.integer :template_id
    end
  end

  def down
    drop_table :repository_groups_templates
  end
end
