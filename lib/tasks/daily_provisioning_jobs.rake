require 'date'
require 'delayed_job'

namespace :daily_provisioning_jobs do 

	desc "creating delayed_jobs for system_guests provisioning on daily base"
	task :daily_provisioning_jobs => :environment do

		#spravit LOG
		#yesterday_jobs = Delayed::Job.all
		#yesterday_jobs.each {|job| job.destroy}

		lessons = Lesson.where('starts_at>=? and starts_at<=?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
		lessons.each do |lesson| 

			lesson.lab.system_hosts.each do |host|

				puts host.ip
				puts host.mac
				puts host.domain
				#SystemGuest.delay( :run_at => lesson.starts_at - 30.minutes )schedule_provisioning()

			end			
		end

		#SystemGuest.create()
	end

	
end