class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :info

      t.integer :course_id

      t.timestamps
    end
  end
end
