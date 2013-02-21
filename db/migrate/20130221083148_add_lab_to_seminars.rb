class AddLabToSeminars < ActiveRecord::Migration
  def change
  	add_column :seminars, :lab_id, :integer
  end
end
