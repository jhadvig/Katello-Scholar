class LessonsController < SecureController

	def index
		@seminar = Seminar.find(params[:seminar_id])
		@lessons = @seminar.lessons
	end

end 