class RepositoryGroupsController < SecureController

	def index
		@repo_groups = RepositoryGroup.all
	end

	def show
		@repo_group = RepositoryGroup.find(params[:id])
	end

	def create
		# binding.pry
		group_name = params.delete(:repository_group_name)
		@repository_group = RepositoryGroup.new(:name => group_name)
		if @repository_group.save

			# Date about repositories sotred in hash like this:
			# {"repo_name1"=>"repo_url1", "repo_name2"=>"repo_url2"}
			repositories_attr = params.delete_if {|k,v| k !~ /\Arepository_.*/}.values
			repository_hashes = Hash[*repositories_attr]
			repository_hashes.each do  |k,v|
				puts "PIPISE => #{k} => #{v}"
				@repository_group.repositories << Repository.create(:name => k, :url => v)
			end

		end

		redirect_to repository_groups_path
	end

	def new
		@repo_group = RepositoryGroup.new
	end

	def edit

	end

	def update

	end

	def destroy

	end


end