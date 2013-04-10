# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin = User.create :name => "admin", :email => "admin@admin.com", :password => "admin"

roles = {"admin"=>1, "lector"=>2, "student"=>3 }
Role.delete_all
roles.each do |k,v|
	Role.create!(:name=>k, :value=>v)
end


# options = {:base_url => 'https://localhost/foreman',
#            :username => 'admin',
#            :password => 'changeme'}
# Architecture = ForemanApi::Resources::Architecture.new options
# Domain = ForemanApi::Resources::Domain.new options

def delete_domains_archs
	architectures = Resources::Foreman::Architecture.index.first
	architectures.each { |a| Resources::Foreman::Architecture.destroy("id"=>a["architecture"]["id"])}
	domains = Resources::Foreman::Domain.index.first
	domains.each { |d| Resources::Foreman::Domain.destroy("id"=>d["domain"]["id"])}
	Architecture.all.each { |a| a.destroy}
rescue
	false
end

def create_domain
	Resources::Foreman::Domain.create(:domain => {:name => "katellolabs.org"})
rescue 
	false
end

def create_architecture
	foreman_id = Resources::Foreman::Architecture.create(:architecture => {:name => "x86_64"}).first["architecture"]["id"]
	Architecture.create(:name => "x86_64", :foreman_id =>foreman_id)
	foreman_id = Resources::Foreman::Architecture.create(:architecture => {:name => "i386"}).first["architecture"]["id"]
	Architecture.create(:name => "i386", :foreman_id =>foreman_id)
rescue 
	false
end

delete_domains_archs
create_domain
create_architecture
