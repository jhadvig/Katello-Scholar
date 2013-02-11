class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.boolean :status
      t.integer :seminars_count

      t.timestamps
    end
  end
end
