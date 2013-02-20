class CreateSystemHosts < ActiveRecord::Migration
  def change
    create_table :system_hosts do |t|
      t.string :name
      t.string :ip
      t.string :mac
      t.string :domain
      t.integer :status

      t.integer :lab_id

      t.timestamps
    end
  end
end
