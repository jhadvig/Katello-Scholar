class SystemHostsController < SecureController

	def index
		@lab = Lab.find(params[:lab_id])
		@system_hosts = @lab.system_hosts
	end

	def new
		@lab = Lab.find(params[:lab_id])
		@system_host = @lab.system_hosts.new(params[:system_host])
		@domain = KatelloScholar::APP_CONFIG["app_config"]["domain"]
	end

	def create
		@lab = Lab.find(params[:lab_id])
		if @system_host = @lab.system_hosts.create(params[:system_host])
			flash[:success] = 'Host was successfully created'
		else
		    flash[:error] = 'Host can\'t be created'
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
		    flash[:error] = 'Host can\'t be updated'
		end
		redirect_to lab_system_hosts_path(@lab)
	end

	def destroy
		@system_host = SystemHost.find(params[:id])
		@lab = @system_host.lab
		if @system_host.destroy
			flash[:success] = 'Host group was successfully deleted.'
		else
		    flash[:error] = 'Host group can\'t be deleted.'
		end

		redirect_to lab_system_hosts_path(@lab)
	end

	def multiple_actions
		if params.include?("host_ids")
			deleted_hosts = []
			updated_hosts = []
			@checked_hosts_ids = params[:host_ids].map(&:to_i)
			@checked_hosts_ids.each do |h|
				host = SystemHost.find(h)
				if params.include?("delete_action")					
					deleted_hosts << host.name if host.destroy
				elsif params.include?("maintain_action")
					updated_hosts << host.name if host.update_attribute(:status, 0)
				elsif params.include?("ready_action")
					updated_hosts << host.name if host.update_attribute(:status, 1)
				end
			end
			unless deleted_hosts.empty?
				flash[:success] = "Host: \n#{deleted_hosts.join("\n")}\n were successfully deleted." 
			else
				flash[:success] = "Host: \n#{updated_hosts.join("\n")}\n were successfully updated."
			end
		end
		flash[:error] = "No hosts checked !" unless params.include?("host_ids")
		redirect_to :back
	end
	
end