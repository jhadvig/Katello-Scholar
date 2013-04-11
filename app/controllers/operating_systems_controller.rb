class OperatingSystemsController < SecureController

	def index 
		@operating_systems = OperatingSystem.all
	end

	def show
		@operating_systems = OperatingSystem.find(params[:id])
	end

	def new
		@operating_system = OperatingSystem.new
		@architectures = Architecture.select('name,id')
	end

	def create
		@operating_system = OperatingSystem.new(params[:operating_system])
		if @operating_system.save
			flash[:success] = "Operating system #{@operating_system.name} was successfully created"
		else
		    flash[:error] = "Operating system can\'t be created"
		end
		redirect_to operating_systems_path
	end

	def edit
		@operating_system = OperatingSystem.find(params[:id])
	end

	def update
		@operating_system = OperatingSystem.find(params[:id])
	end

	def destroy
		@operating_system = OperatingSystem.find(params[:id])
		if @operating_system.destroy
			flash[:success] = "Operating systems #{@operating_system.name} was successfully deleted"
		else
			flash[:error] = "Operating systems #{@operating_system.name} can't be deleted"
		end
		redirect_to operating_systems_path
	end

end