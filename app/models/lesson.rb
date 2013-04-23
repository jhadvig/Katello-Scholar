class Lesson < ActiveRecord::Base
	STATUS = {"Active"=>true,"Inactive"=>false}

	attr_accessible :info, :number, :status, :starts_at, :ends_at, :template_id, :day, :lab_id

	belongs_to :seminar
	belongs_to :template
	belongs_to :lab

	validates :number, :presence => true
	validates :day, :presence=>true
	validates :starts_at, :presence=>true
	validates :ends_at, :presence=>true
	validates :template_id, :presence=>true

	before_create :create_hostgroup
	before_destroy :destroy_hostgroup
	#before_update :update_hostgroup

	def create_hostgroup
		# Single domain use case !!! One Domain - One Subnet - One SmartProxy
		domain_id = Resources::Foreman::Domain.index.first.first["domain"]["id"]
		subnet_id = Resources::Foreman::Subnet.index.first.first["subnet"]["id"]
		ptable_id = Resources::Foreman::Ptable.index(:search => "name ~ RedHat").first.first["ptable"]["id"]
		########

		os_instance = OperatingSystem.find(Template.find(self.template_id).operating_system_id)
		puts "!!!!!!!"
		puts domain_id.inspect
		puts subnet_id.inspect
		puts self.seminar.course.foreman_id.inspect
		puts os_instance.foreman_os_id
		puts Architecture.find(os_instance.architecture_id).foreman_id
		puts os_instance.foreman_medium_id
		puts ptable_id.inspect
		puts "!!!!!!!"
		self.foreman_hostgroup_id = Resources::Foreman::Hostgroup.create(:hostgroup => {:name => "#{self.seminar.course.code}_#{self.seminar.seminar_number}_#{self.number}",
																						:domain_id => domain_id,
																						:subnet_id => subnet_id,
																						:environment_id => self.seminar.course.foreman_id,
																						:operatingsystem_id => os_instance.foreman_os_id,
																						:architecture_id => Architecture.find(os_instance.architecture_id).foreman_id,
																						:medium_id => os_instance.foreman_medium_id,
																						:ptable_id => ptable_id,
																						:root_pass => "redhat"}).first["hostgroup"]["id"]
	rescue
		false
	end

	def destroy_hostgroup
		Resources::Foreman::Hostgroup.destroy("id" => self.foreman_hostgroup_id)
	rescue
		false		
	end


	def find_lesson_dates(lesson_number) 
		semester_start_date = DateTime.strptime(Semester::SEMESTER["start"] ,'%d.%m.%Y')
	  	semester_end_date = DateTime.strptime(Semester::SEMESTER["end"] ,'%d.%m.%Y')
	  	day = Weekday::DAYS.key(self.day)
	  	lesson_dates = []

	  	semester_start_date.upto(semester_end_date) do |date|
	  		lesson_dates << date if ( date.strftime("%A") == day )
	  	end

	  	lesson_date = lesson_dates[lesson_number]
	  	self.starts_at = self.starts_at.change(:year=>lesson_date.year,:month=>lesson_date.month,:day=>lesson_date.day)
	  	self.ends_at = self.ends_at.change(:year=>lesson_date.year,:month=>lesson_date.month,:day=>lesson_date.day)
	  	return
	end

	def lesson_expiration
		if (self.ends_at < DateTime.now) and (self.status == true)
			self.status = !self.status 
			self.save
		end
	end


end
