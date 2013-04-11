class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.string :name
      t.string :major
      t.string :minor
      t.string :path

      t.integer :architecture_id

      t.timestamps
    end
  end
end
