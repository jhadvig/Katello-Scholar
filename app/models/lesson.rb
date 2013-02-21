class Lesson < ActiveRecord::Base
	STATUS = {"Active"=>true,"Inactive"=>false}

	attr_accessible :info, :number, :status, :starts_at, :ends_at, :template_id, :day

	belongs_to :seminar
	belongs_to :template
	has_one :lab

	validates :number, :presence => true
	validates :day, :presence=>true
	validates :starts_at, :presence=>true
	validates :ends_at, :presence=>true
	validates :template_id, :presence=>true

	def find_lesson_dates(lesson_number) 
		semester_start_date = DateTime.strptime(Semester::SEMESTER["start"] ,'%d.%m.%Y')
	  	semester_end_date = DateTime.strptime(Semester::SEMESTER["end"] ,'%d.%m.%Y')
	  	day = Weekday::DAYS.key(self.day)
	  	puts "!!!!!!!!!"
	  	puts day
	  	puts "!!!!!!!!!"
	  	lesson_dates = []

	  	semester_start_date.upto(semester_end_date) do |date|
	  		lesson_dates << date if ( date.strftime("%A") == day )
	  	end

	  	lesson_date = lesson_dates[lesson_number+1]
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
