class OperatingSystemsController < SecureController

	def index 
		@operating_systems = OperatingSystem.all
	end

	def show
		@operating_systems = OperatingSystem.find(params[:id])
	end

	def new
		@operating_system = OperatingSystem.new
	end

	def create
		@operating_system = OperatingSystem.new(params[:operating_system])
	end

	def edit
		@operating_system = OperatingSystem.find(params[:id])
	end

	def update
		@operating_system = OperatingSystem.find(params[:id])
	end

	def destroy
		@operating_system = OperatingSystem.find(params[:id])
	end

end