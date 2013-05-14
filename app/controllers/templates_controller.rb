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

	def show
		@template = Template.find(params[:id])
		@course = @template.course
		@os = @template.operating_system		
	end

	def new
		@course = Course.find(params[:course_id])
		@operating_systems = OperatingSystem.all

		@puppet_groups = PuppetClassGroup.all

		@template = @course.templates.new(params[:template])
		respond_to do |format|
			format.html  # index.html.erb
			format.json { render :json => @templates}
		end
	end

	def create
		@course = Course.find(params[:course_id])
		if @template = @course.templates.new(params[:template])
			unless params[:classes_ids].empty?	
				puts params[:classes_ids]
				params[:classes_ids].each do |id|
					puppet_class = PuppetClass.find(id.to_i)
					@template.puppet_classes << puppet_class
				end
				@template.save
			end
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
		@operating_systems = OperatingSystem.all
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

	def multiple_actions
		if params.include?("template_ids")
			deleted_temp = []
			@checked_temp_ids = params[:template_ids].map(&:to_i)
			@checked_temp_ids.each do |t|
				temp = ::Template.find(t)			
				deleted_temp << temp.name if temp.destroy
			end
			flash[:success] = "Template: \n#{deleted_temp.join("\n")}\n were successfully deleted."
		end
		flash[:error] = "No templates checked !" unless params.include?("template_ids")
		redirect_to :back
	end

end