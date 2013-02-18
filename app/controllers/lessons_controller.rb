class LessonsController < SecureController

	def index
		@seminar = Seminar.find(params[:seminar_id])
		@lessons = @seminar.lessons
	end

	def show
		@lesson = Lesson.find(params[:id])
		@seminar = @lesson.seminar
	end

	def new 
		@seminar = Seminar.find(params[:seminar_id])
		@lessons = @seminar.lessons.new(params[:lesson])
	end

	def create
		@seminar = Seminar.find(params[:seminar_id])
		if @lesson = @seminar.lessons.create(params[:lesson])
			flash[:success] = 'Lesson was successfully created'
		else
		    flash[:error] = 'ERROR: Lesson can\'t be created'
		end
		redirect_to seminar_lessons_path(@seminar)
	end

	def edit
		@lesson = Lesson.find(params[:id])
		@seminar = @lesson.seminar
	end

	def update
		@lesson = Lesson.find(params[:id])
		@seminar = @lesson.seminar
		if @lesson = @lesson.update_attributes(params[:lesson])
			flash[:success] = 'Lesson was successfully updated'
		else
		    flash[:error] = 'ERROR: Lesson can\'t be updated'
		end
		redirect_to seminar_lessons_path(@seminar)
	end

	def destroy
		@lesson = Lesson.find(params[:id])
		@seminar = @lesson.seminar
		if @lesson.destroy
			flash[:success] = 'Lesson group was successfully deleted.'
		else
		    flash[:error] = 'ERROR: Lesson group can\'t be deleted.'
		end
		redirect_to seminar_lessons_path(@seminar)
	end

	def clone
		@lesson = Lesson.find(params[:id])
		@seminar = @lesson.seminar
		@cloned_lesson = @lesson.dup
		@cloned_lesson.number = @lesson.seminar.lessons.count+1
		if @cloned_lesson.save
			flash[:success] = 'Lesson was successfully cloned.'
		else
		    flash[:error] = 'ERROR: Lesson can\'t be cloned.'
		end
		redirect_to seminar_lessons_path(@seminar)

	end

end 