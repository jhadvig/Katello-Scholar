class TemplatesController < SecureController

	before_filter :read_auth, :only => [:index,:show]
	before_filter :manage_auth, :except => [:index,:show]


	def read_auth
		unless can?(:read, Template)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end

	def manage_auth
		unless can?(:manage, Template)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end

	def index

		@templates = Template.all(:order => "course_id ASC")

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
			flash[:success] = 'Template was successfully created'
		else
		    flash[:error] = 'Template can\'t be created'
		end
		redirect_to course_path(@course)
	end

	def edit
		@template = Template.find(params[:id])
		#@template = Template.find(params[:course_id])
		@course = @template.course
	end


	def update
		@template = Template.find(params[:id])
		@course = @template.course
		if @template.update_attributes(params[:template])
			flash[:success] = 'Template was successfully updated'
		else
		    flash[:error] = 'Template can\'t be updated'
		end
		redirect_to course_path(@template.course.id)
	end

	def destroy
		@template = Template.find(params[:id])
		@course = @template.course
		if @template.destroy
			flash[:success] = 'Template group was successfully deleted.'
		else
		    flash[:error] = 'Template group can\'t be deleted.'
		end

		redirect_to course_path(@course)
	end

end