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
		@course.save

		redirect_to courses_path
	end

	def edit 
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])
		@course.update_attributes(params[:course])

		redirect_to courses_path
	end

	def destroy
		@course = Course.find(params[:id])
		@course.destroy
		redirect_to courses_path
	end

	def clone 
		@curr_course = Course.find(params[:id]).dup
		#@cloned_course = Course.new(@curr_course.attributes)
		if @curr_course.save
			flash[:notice] = 'Item was successfully cloned.'
		else
		    flash[:notice] = 'ERROR: Item can\'t be cloned.'
		end
		redirect_to courses_path
	end

end