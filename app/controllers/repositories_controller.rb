class RepositoriesController < SecureController

	def index
		@repositories = Repository.all 
		@repositories.each do |repo|
			repo.status = Net::Ping::TCP.new(repo.url.gsub("http://","").gsub("/",""), 'http').ping?
			repo.save
		end
	end

	def show
		@repository = Repository.find(params[:id])
	end

	def new
		@repository = Repository.new
	end

	def create
		@repository = Repository.new(params[:repository])
		if @repository.save
			flash[:success] = "Repository #{@repository.name} was successfully created"
		else
		    flash[:error] = "Repository #{@repository.name} can\'t be created"
		end
		redirect_to repositories_path
	end

	def edit
		@repository = Repository.find(params[:id])
	end

	def update
		@repository = Repository.find(params[:id])
		if @repository.update_attributes(params[:repository])
			flash[:success] = "Repository #{@repository.name} was successfully updated"
		else
		    flash[:error] = "Repository #{@repository.name} can\'t be updated"
		end
		redirect_to repositories_path
	end

	def destroy
		@repository = Repository.find(params[:id])
		if @repository.destroy
			flash[:success] = "Repository #{@repository.name} was successfully deleted"
		else
			flash[:error] = "Repository #{@repository.name} can't be deleted"
		end
		redirect_to repositories_path
	end

end