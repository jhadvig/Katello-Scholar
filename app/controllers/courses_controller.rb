class CoursesController < SecureController
	
	def index
		@courses = Course.all

		respond_to do |format|
			format.html  # index.html.erb
			format.json { render :json => @posts}
		end
	end

	def new
		@course = Course.new
		respond_to do |format|
    		format.html  # new.html.erb
    		format.json  { render :json => @post }
  		end

	end

	def create
		@course = Course.new(params[:course])
		
		if @course.save
			flash[:success] = 'Course was successfully created'
		else
		    flash[:error] = 'ERROR: Course can\'t be created'
		end

		redirect_to courses_path
	end

	def show
		@course = Course.find(params[:id])
	end

	def edit 
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])

		if @course.update_attributes(params[:course])
			flash[:success] = 'Course was successfully updated'
		else
		    flash[:error] = 'ERROR: Course can\'t be updated'
		end

		redirect_to courses_path
	end

	def destroy
		@course = Course.find(params[:id])
		
		if @course.destroy
			flash[:success] = 'Course was successfully deleted.'
		else
		    flash[:error] = 'ERROR: Course can\'t be deleted.'
		end

		redirect_to courses_path
	end

	def clone 
		@curr_course = Course.find(params[:id]).dup

		if @curr_course.save
			flash[:success] = 'Course was successfully cloned.'
		else
		    flash[:error] = 'ERROR: Course can\'t be cloned.'
		end
		redirect_to courses_path
	end

	def de_active
		@course = Course.find(params[:id])
		
		@course.status = !@course.status
		@course.save

		redirect_to :back
	end

end