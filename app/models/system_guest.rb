class SystemGuest < ActiveRecord::Base

	STATUS = {"Provisioning"=>0,"Running"=>1, "Down"=>2}

	attr_accessible :foreman_host_id, :system_host_id, :lesson_id, :name, :url, :status

	belongs_to :lesson
	belongs_to :system_host

	#validates :name, :presence => true
	#validates :url, :presence => true
	#validates :foreman_host_id, :presence => true
  #validates :system_host_id, :presence =>true

  #after_create :create_guest

  def (lesson_id)
    SystemGuest.create( :name => "DJ_TEST1",
                        :lesson_id => lesson_id,
                        :status => 0)
  end

	def self.foreman_guest_provision(lesson_id)#, name)#,host,hostgroup,subnet)
		#self.foreman_host_id 
    SystemGuest.create(:name => "guest1", :lesson_id => lesson_id)
	end
	# handle_asynchronously :foreman_guest_provision, :run_at => Proc.new {|lecture.starts_at|}

	def generate_password
		(0...8).map{(65+rand(26)).chr}.join.downcase
	end

  def self.schedule_provisioning(name)
    foreman_host_id = Resources::Foreman::Host.create( "host"=> { "puppetclass_ids"=>[""], 
                                                                  "managed"=>"true", 
                                                                  "domain_id"=>"1", 
                                                                  "disk"=>"", 
                                                                  "compute_resource_id"=>"1", 
                                                                  "environment_id"=>"1", 
                                                                  "architecture_id"=>"1", 
                                                                  "name"=>"HOST_NAME", 
                                                                  "compute_attributes" => { 
                                                                    "nics_attributes" => {
                                                                      "new_nics"=>{
                                                                        "bridge"=>"eth0", 
                                                                        "_delete"=>""
                                                                      }, 
                                                                      "0"=>{
                                                                        "bridge"=>"virbr1", 
                                                                        "_delete"=>""
                                                                      }
                                                                    }, 
                                                                    "cpus"=>"1", 
                                                                    "memory"=>"805306368", 
                                                                    "start"=>"1", 
                                                                    "volumes_attributes"=>{
                                                                      "0"=>{
                                                                        "_delete"=>"", 
                                                                        "pool_name"=>"default", 
                                                                        "format_type"=>"raw", 
                                                                        "capacity"=>"10G"
                                                                        }, 
                                                                      "new_volumes"=>{
                                                                        "_delete"=>"", 
                                                                        "pool_name"=>"default", 
                                                                        "format_type"=>"raw", 
                                                                        "capacity"=>"10G"
                                                                        }
                                                                      }
                                                                    }, 
                                                                    "comment"=>"", 
                                                                    "hostgroup_id"=>"1", 
                                                                    "interfaces_attributes"=>{
                                                                      "new_interfaces"=>{
                                                                        "domain_id"=>"", 
                                                                        "ip"=>"", 
                                                                        "type"=>"Nic::Managed", 
                                                                        "provider"=>"IPMI", 
                                                                        "name"=>"", 
                                                                        "_destroy"=>"false", 
                                                                        "mac"=>"", 
                                                                        "subnet_id"=>""
                                                                        }
                                                                      }, 
                                                                    "medium_id"=>"6", 
                                                                    "root_pass"=>"", 
                                                                    "enabled"=>"1", 
                                                                    "puppet_proxy_id"=>"1", 
                                                                    "provision_method"=>"build", 
                                                                    "build"=>"1", 
                                                                    "ptable_id"=>"1", 
                                                                    "mac"=>"", 
                                                                    "subnet_id"=>"1", 
                                                                    "operatingsystem_id"=>"1", 
                                                                    "overwrite"=>"false"
                                                                    } 
                                                                  )

  end


end
