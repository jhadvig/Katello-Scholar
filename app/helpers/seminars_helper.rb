module SeminarsHelper

	def course_seminar(seminar)
		"#{seminar.course.code}/ #{sprintf '%02d', seminar.seminar_number}"
	end

end