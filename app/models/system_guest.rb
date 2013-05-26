class SystemGuest < ActiveRecord::Base

	STATUS = {"Provisioning"=>0,"Running"=>1, "Down"=>2}

	attr_accessible :foreman_host_id, :system_host_id, :lesson_id, :name, :url, :status

	belongs_to :lesson
	belongs_to :system_host

	#validates :name, :presence => true
	#validates :url, :presence => true
	#validates :foreman_host_id, :presence => true
  #validates :system_host_id, :presence =>true

	def self.generate_password
		(0...8).map{(65+rand(26)).chr}.join.downcase
	end


  def foreman_host_reprovisioning()
    if foreman_host_attributes = Resources::Foreman::Host.destroy("id"=>self.foreman_host_id).first["host"]
      #SystemGuest.foreman_host_provisioning(guest_id,
                                           # name,
                                           # root_pass,
                                           # foreman_host_attributes["environment_id"],
                                           # foreman_host_attributes["architecture_id"],
                                           # foreman_host_attributes["hostgroup_id"],
                                           # foreman_host_attributes["medium_id"],
                                           # foreman_host_attributes["puppet_proxy_id"],
                                           # foreman_host_attributes["ptable_id"],
                                           # foreman_host_attributes["domain_id"],
                                           # foreman_host_attributes["subnet_id"],
                                           # foreman_host_attributes["compute_resource_id"],
                                           # foreman_host_attributes["operatingsystem_id"],
                                           # foreman_host_attributes["puppetclass_ids"])
    end
  rescue 
    false
  end


  # def self.foreman_host_provisioning(guest_id,name,root_pass,environment_id,architecture_id, hostgroup_id,
  #                                medium_id, puppet_proxy_id, ptable_id, domain_id, subnet_id,
  #                                compute_resource_id,operatingsystem_id,puppetclass_ids)
  # end
  def self.foreman_host_provisioning()

    foreman_host_attributes = Resources::Foreman::Host.create( "host"=> { "puppetclass_ids"=>[""], 
                                                                  "managed"=>"true", 
                                                                  "domain_id"=>"1", 
                                                                  "disk"=>"", 
                                                                  "compute_resource_id"=>"1", 
                                                                  "environment_id"=>"1", 
                                                                  "architecture_id"=>"1", 
                                                                  "name"=>"guest", 
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
                                                                  ).first["host"]
    #guest = SystemGuest.find(guest_id)
    #guest.status = 0
    #guest.url = foreman_host_attributes["ip"]
    #guest.foreman_host_id = foreman_host_attributes["id"]
    #guest.save
    rescue 
      false
  end


end
