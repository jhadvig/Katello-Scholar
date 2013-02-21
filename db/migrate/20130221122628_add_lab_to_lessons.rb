class AddLabToLessons < ActiveRecord::Migration
  def change
  	add_column :lessons, :lab_id, :integer
  end
end
