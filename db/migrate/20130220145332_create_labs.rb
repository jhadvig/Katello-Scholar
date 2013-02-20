class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.text :info
      t.integer :status
      t.integer :lesson_id 

      t.timestamps
    end
  end
end
