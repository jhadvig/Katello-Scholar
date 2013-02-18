class Lesson < ActiveRecord::Base
	STATUS = {"Active"=>true,"Inactive"=>false}

	attr_accessible :info, :number, :status, :starts_at, :ends_at, :template_id

	belongs_to :seminar
	belongs_to :template

	def find_lesson_dates(lesson_number) #TODO
		semester_start_date = DateTime.strptime(Semester::SEMESTER["start"] ,'%d.%m.%Y')
	  	semester_end_date = DateTime.strptime(Semester::SEMESTER["end"] ,'%d.%m.%Y')
	  	day = Weekday::DAY.key(self.seminar.day)
	  	lesson_dates = []

	  	semester_start_date.upto(semester_end_date) do |date|
	  		lesson_dates << date if ( date.strftime("%A") == day )
	  	end

	  	lesson_date = lesson_dates[lesson_number-1]

	  	self.starts_at.change(:year=>lesson_date.year,:month=>lesson_date.month,:day=>lesson_date.day)
	  	self.starts_at.change(:year=>lesson_date.year,:month=>lesson_date.month,:day=>lesson_date.day)

	end

end
