class AddEnvIdToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :foreman_id, :integer
  end
end
