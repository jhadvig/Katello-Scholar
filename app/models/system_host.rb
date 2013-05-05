class SystemHost < ActiveRecord::Base

	STATUS = {"Maintenance"=>0,"Ready"=>1, "Occupied"=>2}

	@ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
	@mac_regex = /^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$/
	attr_accessible :domain, :ip, :mac, :name, :status
	belongs_to :lab
	has_many :system_guests,:dependent => :destroy

	validates :name, :presence => true, :uniqueness => true
	validates :ip, :presence => true, :uniqueness => true, :on => :save, :format => { :with => @ip_regex }
	validates :mac, :presence => true, :uniqueness => true#, :on => :save, :format => { :with => @mac_regex }
	validates :domain, :presence => true


	def status_is
		SystemHost::STATUS.key(self.status)
	end

end
