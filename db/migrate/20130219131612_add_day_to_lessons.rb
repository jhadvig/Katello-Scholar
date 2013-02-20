class AddDayToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :day, :integer
  end

  def down
  	remove_column :lessons, :day
  end
end
