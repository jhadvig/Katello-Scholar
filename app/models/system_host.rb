class SystemHost < ActiveRecord::Base

	STATUS = {"Maintenance"=>0,"Ready"=>1, "Occupied"=>2}

	attr_accessible :domain, :ip, :mac, :name, :status
	belongs_to :lab

	def status_is
		SystemHost::STATUS.key(self.status)
	end

end
