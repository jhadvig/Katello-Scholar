class SystemGuestsController < SecureController

	def index
		
		@lesson = Lesson.find(params[:lesson_id])
		@lab = @lesson.lab
		@hosts = @lesson.lab.system_hosts

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