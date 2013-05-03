class CreateSystemGuests < ActiveRecord::Migration
  def change
    create_table :system_guests do |t|
      t.string :name
      t.string :url
      t.integer :lesson_id
      t.integer :foreman_host_id
      t.integer :system_host_id

      t.timestamps
    end
  end
end
