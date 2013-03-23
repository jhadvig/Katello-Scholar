class CoursesController < SecureController

	before_filter :read_auth, :only => [:index,:show]
	before_filter :manage_auth, :except => [:index,:show]



	def read_auth
		unless can?(:read, Course)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end

	def manage_auth
		unless can?(:manage, Course)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end


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
		    flash[:error] = 'Course can\'t be created'
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
		    flash[:error] = 'Course can\'t be updated'
		end

		redirect_to courses_path
	end

	def destroy
		@course = Course.find(params[:id])
		if @course.can_destroy?
			if @course.destroy
				flash[:success] = 'Course was successfully deleted.'
			else
			    flash[:error] = 'Course can\'t be deleted.'
			end
			redirect_to courses_path
		else
			flash[:error] = 'Course can\'t be deleted because is still Active.'
			puts params[:action]
			redirect_to courses_path
		end
	end

	def clone 
		@curr_course = Course.find(params[:id]).dup


		if @curr_course.save
			flash[:success] = 'Course was successfully cloned.'
		else
		    flash[:error] = 'Course can\'t be cloned.'
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