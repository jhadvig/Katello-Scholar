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
		    flash[:error] = 'ERROR: Lab can\'t be created'
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
		if @lab.update_attributes(params[:course])
			flash[:success] = 'Lab was successfully updated'
		else
		    flash[:error] = 'ERROR: Lab can\'t be updated'
		end
		redirect_to labs_path
	end

	def destroy
		@lab = Lab.find(params[:id])
		if @lab.destroy
			flash[:success] = 'Lab was successfully deleted.'
		else
		    flash[:error] = 'ERROR: Lab can\'t be deleted.'
		end
		redirect_to labs_path
	end

end