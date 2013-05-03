class LabsController < SecureController

	def index
		@labs = Lab.all(:order => "name ASC")
		respond_to do |format|
			format.html 
			format.json { render :json => @labs}
		end
	end

	def new
		@lab = Lab.new
	end

	def create
		@lab = Lab.new(params[:lab])
		if @lab.save
			flash[:success] = 'Lab was successfully created'
		else
		    flash[:error] = 'Lab can\'t be created'
		end
		redirect_to labs_path
	end

	def show
		@lab = Lab.find(params[:id])
	end

	def edit
		@lab = Lab.find(params[:id])
	end

	def update
		@lab = Lab.find(params[:id])
		if @lab.update_attributes(params[:lab])
			flash[:success] = 'Lab was successfully updated'
		else
		    flash[:error] = 'Lab can\'t be updated'
		end
		redirect_to labs_path
	end

	def destroy
		@lab = Lab.find(params[:id])
		if @lab.destroy
			flash[:success] = 'Lab was successfully deleted.'
		else
		    flash[:error] = 'Lab can\'t be deleted.'
		end
		redirect_to labs_path
	end

	def multiple_actions
		if params.include?("lab_ids")
			deleted_labs = []
			updated_labs = []
			@checked_lab_ids = params[:lab_ids].map(&:to_i)
			@checked_lab_ids.each do |l|
				lab = Lab.find(l)
				if params.include?("delete_action")			
					deleted_labs << lab.name if lab.destroy
				elsif params.include?("maintain_action")
					updated_labs << lab.name if lab.update_attribute(:status, 0)
				elsif params.include?("ready_action")
					updated_labs << lab.name if lab.update_attribute(:status, 1)
				end

			end
			unless deleted_labs.empty?
				flash[:success] = "Lab: \n#{deleted_labs.join("\n")}\n were successfully deleted."
			else
				flash[:success] = "Lab: \n#{updated_labs.join("\n")}\n were successfully updated."
			end
		end
		flash[:error] = "No labs checked !" unless params.include?("lab_ids")
		redirect_to :back
	end

end