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

		if current_user.admin?
			@courses = Course.all
		else
			@courses = []
			current_user.seminars.each {|seminar| @courses << seminar.course }
			@courses.uniq!
		end

		respond_to do |format|
			format.html  # index.html.erb
			format.json { render :json => @courses}
		end

	end

	def new
		@course = Course.new
		respond_to do |format|
    		format.html  # new.html.erb
    		format.json  { render :json => @course }
  		end

	end

	def create
		@course = Course.new(params[:course])
		
		if @course.save
			flash[:success] = "Course #{@course.course_code_name} was successfully created"
		else
		    flash[:error] = "Course can\'t be created"
		end

		redirect_to courses_path
	end

	def show
		@course = Course.find(params[:id])
		if current_user.admin?
			@seminars = @course.seminars
		else
			@seminars = []
			current_user.seminars.each {|seminar| @seminars << seminar if seminar.course.id == @course.id}
		end
	end

	def edit 
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])

		if @course.update_attributes(params[:course])

			flash[:success] = "Course #{@course.course_code_name} was successfully updated"
		else
		    flash[:error] = "Course can\'t be updated"
		end

		redirect_to courses_path
	end

	def destroy
		@course = Course.find(params[:id])
		if @course.can_destroy?
			if @course.destroy
				flash[:success] = "Course #{@course.course_code_name} was successfully deleted."
			else
			    flash[:error] = "Course can\'t be deleted."
			end
			redirect_to courses_path
		else
			flash[:error] = "Course can\'t be deleted because is still Active."
			puts params[:action]
			redirect_to courses_path
		end
	end

	def multiple_actions
		deleted_courses = []
		@checked_courses_ids = params[:courses_ids].map(&:to_i)
		@checked_courses_ids.each do |c|
			course = Course.find(c)
			if params.include?("delete_action")
			 	if course.destroy
			 		deleted_courses << course.course_code_name
			 	end
			elsif params.include?("activate_action")
				course.activate_course
				course.save
			elsif params.include?("deactivate_action")
				course.deactivate_course
				course.save
			end
		end

		flash[:success] = "Course: \n#{deleted_courses.join("\n")}\n was successfully deleted." unless deleted_courses.empty?

		redirect_to courses_path
	end

	def de_active
		@course = Course.find(params[:id])
		
		@course.status = !@course.status
		@course.save

		redirect_to :back
	end

end