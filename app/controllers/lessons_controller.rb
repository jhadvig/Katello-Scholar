class LessonsController < SecureController

	before_filter :read_auth, :only => [:index,:show]
	before_filter :manage_auth, :except => [:index,:show]

	def read_auth
		unless can?(:read, Lesson)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end

	def manage_auth
		unless can?(:manage, Lesson)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end

	def index
		@seminar = Seminar.find(params[:seminar_id])
		@lessons = @seminar.lessons
		@lessons.each {|lesson| lesson.lesson_expiration}
	end

	def show
		@lesson = Lesson.find(params[:id])
		@seminar = @lesson.seminar
	end

	def new 
		@seminar = Seminar.find(params[:seminar_id])
		@lessons = @seminar.lessons.new(params[:lesson])
		gon.starts_at = @seminar.starts_at.strftime("%R")
		gon.ends_at = @seminar.ends_at.strftime("%R")
	end

	def create
		@seminar = Seminar.find(params[:seminar_id])
		@lesson = @seminar.lessons.create(params[:lesson])

		@lesson.find_lesson_dates(@seminar.lessons.count)

		if @lesson.save
			flash[:success] = 'Lesson was successfully created'
		else
		    flash[:error] = 'ERROR: Lesson can\'t be created'
		end
		
		redirect_to seminar_lessons_path(@seminar)
	end

	def edit
		@lesson = Lesson.find(params[:id])
		@seminar = @lesson.seminar
		gon.starts_at = @seminar.starts_at.strftime("%R")
		gon.ends_at = @seminar.ends_at.strftime("%R")
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

		@cloned_lesson.find_lesson_dates(@seminar.lessons.count)

		if @cloned_lesson.save
			flash[:success] = 'Lesson was successfully cloned.'
		else
		    flash[:error] = 'ERROR: Lesson can\'t be cloned.'
		end
		redirect_to seminar_lessons_path(@seminar)
	end

	def de_active
		@lesson = Lesson.find(params[:id])
		
		@lesson.status = !@lesson.status
		@lesson.save

		redirect_to :back
	end

end 