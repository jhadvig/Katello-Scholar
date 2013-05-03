class Lab < ActiveRecord::Base

	STATUS = {"Maintenance"=>0,"Ready"=>1, "Occupied"=>2}

	@ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/

	attr_accessible :info, :name, :lesson_id, :status, :network, :netmask 

	has_many :lessons
	has_many :seminars
	has_many :system_hosts, :dependent => :delete_all

	validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 3, :maximum => 10}
	validates :network, :presence => true, :uniqueness => true#, :on => :save, :format => { :with => @ip_regex }
	validates :netmask, :presence => true, :uniqueness => true#, :on => :save, :format => { :with => @ip_regex }  

	# Foreman resources created: -Subnet
  	#
  	# Single domain use case !!! One Domain - One Subnet - One SmartProxy
  	# 
	# before_create :create_subnet
	# before_destroy :destroy_subnet
	# before_update :update_subnet

	def create_subnet
		foreman_domain_id = Resources::Foreman::Domain.index.first.first["domain"]["id"]

		self.foreman_subnet_id = Resources::Foreman::Subnet.create(:subnet => {:name => self.name,
										                					   :network => self.network,
										                					   :mask => self.netmask,
										                				  #:dns_id => proxy_id,
										                				  #:dhcp_id => proxy_id,
										                				  #:tftp_id => proxy_id,
										                				       :domain_ids => [foreman_domain_id]}).first["subnet"]["id"]
	rescue
		false
	end

	def destroy_subnet
		Resources::Foreman::Subnet.destroy("id" => self.foreman_subnet_id)
	rescue
		false
	end

	def update_subnet
		Resources::Foreman::Subnet.update( "id" => self.foreman_subnet_id, :subnet => { :name => self.name,
																						:network => self.network,
																						:mask => self.netmask })
	rescue
		false
	end

end

