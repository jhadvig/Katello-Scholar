class AddPuppetClassesIdToPuppetClassGroup < ActiveRecord::Migration
  def change
  	add_column :puppet_classes, :puppet_class_group_id, :integer
  end
end
