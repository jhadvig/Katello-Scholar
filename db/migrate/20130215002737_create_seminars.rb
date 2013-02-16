class CreateSeminars < ActiveRecord::Migration
  def change
    create_table :seminars do |t|
      t.integer :seminar_number
      t.integer :day
      t.time :starts_at
      t.time :ends_at
      t.text :info

      t.integer :course_id

      t.timestamps
    end
  end

  def down
    drop_table :seminars
  end
end
