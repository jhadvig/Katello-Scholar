class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.string :name
      t.string :major
      t.string :minor
      t.string :path
      t.string :os_family

      t.integer :architecture_id
      t.integer :foreman_medium_id
      t.integer :foreman_os_id

      t.timestamps
    end
  end
end
