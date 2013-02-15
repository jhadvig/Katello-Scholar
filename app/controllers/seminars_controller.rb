class SeminarsController < SecureController

	def index
		@course = Course.find(params[:course_id])
		@seminars = @course.seminars

		puts @seminars

		respond_to do |format|
			format.html  # index.html.erb
			format.json { render :json => @seminars}
		end
	end

	def new
		@course = Course.find(params[:course_id])
		@seminar = @course.seminars.new(params[:seminar])
		respond_to do |format|
			format.html  # index.html.erb
			format.json { render :json => @seminars}
		end
	end

	def create
		@course = Course.find(params[:course_id])
		
		if @seminar = @course.seminars.create(params[:seminar])
			flash[:success] = 'Seminar was successfully created'
		else
		    flash[:error] = 'ERROR: Seminar can\'t be created'
		end
		redirect_to course_seminars_path
	end

	def edit
		@seminar = Seminar.find(params[:id])
	end

	def show 
		@seminar = Seminar.find(params[:id])
	end

end