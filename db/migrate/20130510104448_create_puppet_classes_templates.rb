class CreatePuppetClassesTemplates < ActiveRecord::Migration
  def up
  	create_table :puppet_classes_templates, :id => false do |t|
	  	t.integer :puppet_class_id
		t.integer :template_id
	end
  end

  def down
  	drop_table :puppet_classes_templates
  end
end
