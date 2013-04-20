class RemoveSeminarsCountFromCourses < ActiveRecord::Migration
  def up
  	remove_column :courses, :seminars_count
  end

  def down
  	add_column :courses, :seminars_count, :integer
  end
end
