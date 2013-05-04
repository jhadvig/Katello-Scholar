class AddStatusToSystemGuest < ActiveRecord::Migration
  def change
    add_column :system_guests, :status, :integer
  end

  def down
  	remove_column :system_guests, :status
  end
end
