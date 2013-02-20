class SystemHostsController < SecureController

	def index
		@lab = Lab.find(params[:lab_id])
		@system_hosts = @lab.system_hosts
	end

	def new
		@lab = Lab.find(params[:lab_id])
		@system_host = @lab.system_hosts.new(params[:system_host])
	end

	def create
		@lab = Lab.find(params[:lab_id])
		if @system_host = @lab.system_hosts.create(params[:system_host])
			flash[:success] = 'Host was successfully created'
		else
		    flash[:error] = 'ERROR: Host can\'t be created'
		end
		redirect_to lab_system_hosts_path(@lab)
	end

	def edit
		@system_host = SystemHost.find(params[:id])
	end

	def update
		@system_host = SystemHost.find(params[:id])
		@lab = @system_host.lab
		if @system_host.update_attributes(params[:system_host])
			flash[:success] = 'Host was successfully updated'
		else
		    flash[:error] = 'ERROR: Host can\'t be updated'
		end
		redirect_to lab_system_hosts_path(@system_host)
	end

	def destroy
		@system_host = SystemHost.find(params[:id])
		@lab = @system_host.lab
		if @system_host.destroy
			flash[:success] = 'Host group was successfully deleted.'
		else
		    flash[:error] = 'ERROR: Host group can\'t be deleted.'
		end

		redirect_to lab_system_hosts_path(@system_host)
	end
	
end