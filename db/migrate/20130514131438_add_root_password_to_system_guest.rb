class AddRootPasswordToSystemGuest < ActiveRecord::Migration
  def change
  	add_column :system_guests, :root_password, :string
  end

  def down
  	remove_column :system_guests, :root_password
  end
end
