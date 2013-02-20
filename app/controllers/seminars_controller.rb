class SeminarsController < SecureController

	before_filter :read_auth, :only => [:index,:show]
	before_filter :manage_auth, :except => [:index,:show]



	def read_auth
		unless can?(:read, Seminar)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end

	def manage_auth
		unless can?(:manage, Seminar)
			flash[:error] = 'You don\'t have the permission to do this action'
		  	redirect_to :back
		end
	end

	def index
		@course = Course.find(params[:course_id])
		@seminars = @course.seminars
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
		redirect_to course_path(@course)
	end


	def edit
		@seminar = Seminar.find(params[:id])
		gon.starts_at = @seminar.starts_at.strftime("%R")
		gon.ends_at = @seminar.ends_at.strftime("%R")
	end


	def update
		@seminar = Seminar.find(params[:id])
		if @seminar.update_attributes(params[:seminar])
			flash[:success] = 'Course was successfully updated'
		else
		    flash[:error] = 'ERROR: Course can\'t be updated'
		end
		redirect_to course_path(@seminar.course.id)
	end


	def show 
		@seminar = Seminar.find(params[:id])
	end

	def destroy
		@seminar = Seminar.find(params[:id])
		@course = @seminar.course
		if @seminar.destroy
			flash[:success] = 'Seminar group was successfully deleted.'
		else
		    flash[:error] = 'ERROR: Seminar group can\'t be deleted.'
		end

		redirect_to course_path(@course)
	end


end