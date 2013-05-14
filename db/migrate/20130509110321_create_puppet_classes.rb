class CreatePuppetClasses < ActiveRecord::Migration
  def change
    create_table :puppet_classes do |t|
      t.integer :foreman_id
      t.integer :template_id
      t.string :name

      t.timestamps
    end
  end
end
