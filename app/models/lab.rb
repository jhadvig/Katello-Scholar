class Lab < ActiveRecord::Base

	STATUS = {"Maintenance"=>0,"Ready"=>1, "Occupied"=>2}

	attr_accessible :info, :name, :lesson_id, :status

	belongs_to :lesson
	has_many :system_hosts

	validates :name, :presence => true, :length => { :minimum => 3, :maximum => 10}


end

