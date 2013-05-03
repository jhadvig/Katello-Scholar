class OperatingSystemsController < SecureController

	def index 
		@operating_systems = OperatingSystem.all
	end

	def show
		@operating_system = OperatingSystem.find(params[:id])
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
		    flash[:error] = "Operating system #{@operating_system.name} can\'t be created"
		end
		redirect_to operating_systems_path
	end

	def edit
		@operating_system = OperatingSystem.find(params[:id])
		@architecture = Architecture.find(@operating_system.architecture_id)
		puts @architecture.name
	end

	def update
		@operating_system = OperatingSystem.find(params[:id])
		if @operating_system.update_attributes(params[:operating_system])
			flash[:success] = "Operating system #{@operating_system.name} was successfully updated"
		else
		    flash[:error] = "Operating system #{@operating_system.name} can\'t be updated"
		end
		redirect_to operating_systems_path
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

	def multiple_actions
		if params.include?("host_ids")
			deleted_os = []
			@checked_os_ids = params[:os_ids].map(&:to_i)
			@checked_os_ids.each do |o|
				os = OperatingSystem.find(o)			
				deleted_os << os.full_name if os.destroy
			end
			flash[:success] = "Operating systems: \n#{deleted_os.join("\n")}\n were successfully deleted."
		end
		flash[:error] = "No operating systems checked !" unless params.include?("host_ids")
		redirect_to :back
	end

end