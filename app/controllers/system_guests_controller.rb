class SystemGuestsController < SecureController

	def index
		
		@lesson = Lesson.find(params[:lesson_id])
		@lab = @lesson.lab
		@hosts = @lesson.lab.system_hosts
		@guests = @lesson.system_guests
		@os = OperatingSystem.find(Template.find(@lesson.template_id).operating_system_id)

	end

	def show
		
	end

	def create
		
	end

	def new
		
	end

	def edit
		
	end

	def update

	end

	def destroy

	end



end