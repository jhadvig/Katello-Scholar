class SystemGuest < ActiveRecord::Base

	STATUS = {"Provisioning"=>0,"Ready"=>1, "Down"=>2}

  	attr_accessible :foreman_host_id, :host_id, :lesson_id, :name, :url
  
  	belongs_to :lesson
  	belongs_to :system_host

  	#validates :name, :presence => true
  	#validates :url, :presence => true
  	#validates :foreman_host_id, :presence => true



  	def foreman_guest_provision(name,host,hostgroup,subnet)
  		self.foreman_host_id 
  		SystemGuest.new(:name => name)
  	end

	def generate_password
		(0...8).map{(65+rand(26)).chr}.join.downcase
	end


end
