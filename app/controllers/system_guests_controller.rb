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

	def power_off
		@guest = SystemGuest.find(params[:id])
		@guest.status = 2
		@guest.save
	end

	def power_on
		@guest = SystemGuest.find(params[:id])
		@guest.status = 1
		@guest.save
	end

	def reprovision
		@guest = SystemGuest.find(params[:id])
		@guest.status = 0
		if @guest.save
			flash[:success] = "Guest #{@guest.name} is being reprovisioned."
			#@guest.foreman_host_reprovisioning
		else
		    flash[:error] = 'Guest #{@guest.name} can\'t be reprovisioned.'
		end
		redirect_to lesson_system_guests_path(@guest.lesson.id)
	end


end