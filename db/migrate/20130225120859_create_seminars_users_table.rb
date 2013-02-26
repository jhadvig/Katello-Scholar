class CreateSeminarsUsersTable < ActiveRecord::Migration
	def up
	  	create_table :seminars_users, :id => false do |t|
	  		t.integer :seminar_id
	  		t.integer :user_id
	  	end
	end

	def down
		drop_table :seminars_users
	end
end
