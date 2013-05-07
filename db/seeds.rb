# def create_roles
	# puts "creating roles"
	# roles = {"admin"=>1, "lector"=>2, "student"=>3 }
	# Role.delete_all
	# roles.each do |k,v|
	# 	Role.create!(:name=>k, :value=>v)
	# end
# end

# def create_admin
#   puts "creating admin"
# 	admin = User.create :email => "admin@admin.com", :password => "admin"
# 	admin_role = Role.find_by_name("admin")
# 	admin.roles << admin_role
# 	admin.save
# end



def delete_domains_archs_subnets
	puts "Deleting Foreman Architectures"
	foreman_architectures = Resources::Foreman::Architecture.index.first
	foreman_architectures.each { |a| Resources::Foreman::Architecture.destroy("id"=> a["architecture"]["id"])}

	Architecture.all.each { |a| a.destroy}

	puts "Deleting Foreman Domains"
	foreman_domains = Resources::Foreman::Domain.index.first
	foreman_domains.each { |d| Resources::Foreman::Domain.destroy("id" => d["domain"]["id"] )} unless foreman_domains.empty?

	puts "Deleting Foreman Subnets"
	foreman_subnets = Resources::Foreman::Subnet.index.first
	foreman_subnets.each { |s| Resources::Foreman::Subnet.destroy("id" => s["subnet"]["id"] )} unless foreman_subnets.empty?

	puts "Deleting Foreman SmartProxies"
	foreman_proxies = Resources::Foreman::SmartProxy.index.first
	foreman_proxies.each { |p| Resources::Foreman::SmartProxy.destroy("id" => p["smart_proxy"]["id"] )} unless foreman_proxies.empty?
rescue
	false
end


def create_architectures
	puts "Creating Architectures"
	foreman_id = Resources::Foreman::Architecture.create(:architecture => {:name => "x86_64"}).first["architecture"]["id"]
	Architecture.create(:name => "x86_64", :foreman_id =>foreman_id)
	foreman_id = Resources::Foreman::Architecture.create(:architecture => {:name => "i386"}).first["architecture"]["id"]
	Architecture.create(:name => "i386", :foreman_id =>foreman_id)
rescue 
	false
end

def create_subnet(domain_id)#,proxy_id)
	puts "Creating Subnet"
	foreman_subnet_id = Resources::Foreman::Subnet.create(:subnet=>{:name => "main",
										                			:network => "192.168.100.0",
										                			:mask => "255.255.255.0",
										                			#:dns_id => proxy_id,
										                			#:dhcp_id => proxy_id,
										                			#:tftp_id => proxy_id,
										                			:domain_ids => [domain_id] }).first["subnet"]["id"]
rescue
	false
end

def create_domain#(proxy_id)
	puts "Creating Domain"
	Resources::Foreman::Domain.create(:domain => {:name => KatelloScholar::APP_CONFIG["app_config"]["domain"] }).first["domain"]
rescue 
	false
end

def create_proxy
	puts "Creating SmartProxy" 
  	Resources::Foreman::SmartProxy.create(:smart_proxy => {:name => "master",
                                     						:url => "http://master.katello-scholar.org:9090"}).first["smart_proxy"]
rescue 
	false
end


delete_domains_archs_subnets

create_architectures

# First prepare Smart Proxy, then create it
#proxy = create_proxy

domain = create_domain#(proxy["id"])

create_subnet(domain["id"])#,proxy["id"])


create_roles
create_admin





