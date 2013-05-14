class CreatePuppetClassGroups < ActiveRecord::Migration
  def change
    create_table :puppet_class_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
