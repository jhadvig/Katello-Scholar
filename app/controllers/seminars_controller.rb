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
	end

	def new
		@course = Course.find(params[:course_id])
		@labs = Lab.all(:order => "name ASC")
		@course_seminars_count = @course.seminars.count
		@seminar = @course.seminars.new(params[:seminar])

		@users = User.where("email like ?","%#{params[:q]}%")
		respond_to do |format|
			format.html
			format.json do
				render :json => @users.map { |user| {:id => user.id, :name => user.email}}
			end
		end
	end


	def create
		puts params[:seminar][:users].class
		@course = Course.find(params[:course_id])
		params[:seminar][:users] = params[:seminar][:users].split(",").map {|i| User.find(i.to_i)}
		if @seminar = @course.seminars.create(params[:seminar])
			flash[:success] = 'Seminar was successfully created'
		else
		    flash[:error] = 'ERROR: Seminar can\'t be created'
		end
		redirect_to course_path(@course)
	end


	def edit
		@seminar = Seminar.find(params[:id])
		@labs = Lab.all(:order => "name ASC")
		@pre_users = @seminar.users
		puts @pre_users
		gon.starts_at = @seminar.starts_at.strftime("%R")
		gon.ends_at = @seminar.ends_at.strftime("%R")

		puts @pre_users.map {|user| {:id=>user.id, :name=>user.email}.to_json}

		@users = User.where("email like ?","%#{params[:q]}%")
		respond_to do |format|
			format.html
			format.json do
				render :json => @users.map { |user| {:id => user.id, :name => user.email}}
			end
		end
	end


	def update
		@seminar = Seminar.find(params[:id])
		params[:seminar][:users] = params[:seminar][:users].split(",").map {|i| User.find(i.to_i)}
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