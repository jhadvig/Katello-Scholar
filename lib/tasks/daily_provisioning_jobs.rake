require 'date'
require 'delayed_job'

namespace :daily_provisioning_jobs do 

	desc "creating delayed_jobs for system_guests provisioning on daily base"
	task :daily_provisioning_jobs => :environment do


		lessons = Lesson.where('starts_at>=? and starts_at<=?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
		lessons.each do |lesson| 
			
			puts "hostgroup_id = #{lesson.foreman_hostgroup_id}"
			puts "compute_resource_id = "
			puts 
			#SystemGuest.schedule_provisioning
			
		end
	end

	
end