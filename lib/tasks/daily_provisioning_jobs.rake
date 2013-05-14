require 'date'
require 'delayed_job'

namespace :daily_provisioning_jobs do 

	desc "creating delayed_jobs for system_guests provisioning on daily base"
	task :daily_provisioning_jobs => :environment do

		#spravit LOG
		#yesterday_jobs = Delayed::Job.all
		#yesterday_jobs.each {|job| job.destroy}

		domain_id = 		Resources::Foreman::Domain.index.first.first["domain"]["id"]
		subnet_id = 		Resources::Foreman::Subnet.index.first.first["subnet"]["id"]
		ptable_id = 		Resources::Foreman::Ptable.index(:search => "name ~ RedHat").first.first["ptable"]["id"]
		puppet_proxy_id = 	Resources::Foreman::SmartProxy.index.first.first["smart_proxy"]["id"]
		# puppet_proxy_id = 1
		# ptable_id = 1
		# domain_id = 1
		# subnet_id = 1

		lessons = Lesson.where('starts_at>=? and starts_at<=?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
		lessons.each do |lesson| 

			lesson.lab.system_guests.each do |guest|

				# Provisioning data IDs
				environment_id = lesson.seminar.course.foreman_id
				architecture_id = lesson.template.operating_system.architecture.foreman_id
				hostgroup_id = lesson.foreman_hostgroup_id
				medium_id =  lesson.template.operating_system.foreman_medium_id
				compute_resources_id = 1 # guest.system_host.foreman_resource_id
				operating_system_id = lesson.template.operating_system.foreman_os_id
				puppetclass_ids = lesson.template.puppet_classes.select("foreman_id").collect { |k| k.foreman_id }
				root_password = "" # TO_DO guest.root_password + migration
				name = "guest"

				#SystemGuest.delay( :run_at => lesson.starts_at - 30.minutes )foreman_guest_provisioning(name,
																										# root_pass,
																										# environment_id,
																										# architecture_id,
																										# hostgroup_id,
																										# medium_id,
																										# puppet_proxy_id,
																										# ptable_id,
																										# domain_id,
																										# subnet_id,
																										# compute_resources_id,
																										# operating_system_id,
																										# puppetclass_ids,
																										# )

			end			
		end

		#SystemGuest.create()
	end

	
end