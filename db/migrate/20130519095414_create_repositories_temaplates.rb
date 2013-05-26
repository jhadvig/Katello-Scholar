class CreateRepositoriesTemaplates < ActiveRecord::Migration
  def up
  	create_table :repositories_templates, :id => false do |t|
  		t.integer :repository_id
  		t.integer :template_id
  	end
  end

  def down
  	drop_table :repositories_templates
  end
end
