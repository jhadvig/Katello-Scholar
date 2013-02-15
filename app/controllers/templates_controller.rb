class TemplatesController < SecureController

	def index
		@course = Course.find(params[:course_id])
		@templates = @course.templates

		respond_to do |format|
			format.html  # index.html.erb
			format.json { render :json => @templates}
		end
	end

	def new
		@course = Course.find(params[:course_id])
		@template = @course.templates.new(params[:template])
		respond_to do |format|
			format.html  # index.html.erb
			format.json { render :json => @templates}
		end
	end

	def create
		@course = Course.find(params[:course_id])
		if @template = @course.templates.create(params[:template])
			flash[:success] = 'Seminar was successfully created'
		else
		    flash[:error] = 'ERROR: Seminar can\'t be created'
		end
		redirect_to course_path(@course)
	end

end