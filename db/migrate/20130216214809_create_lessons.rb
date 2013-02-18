class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :number
      t.boolean :status
      t.text :info
      t.datetime :starts_at
      t.datetime :ends_at

      t.integer :seminar_id
      t.integer :template_id

      t.timestamps
    end
  end
end
