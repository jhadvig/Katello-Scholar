class UsersController < SecureController

	def index

		@admins=Role.find_by_name(:admin).users
		@lectors=Role.find_by_name(:lector).users
		@students=Role.find_by_name(:student).users

	end

	def edit
		@user = User.find(params[:id])
		render "devise/registrations/edit"
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			flash[:success] = "User #{@user.email} was successfully delete."
		else
			flsh[:error] = 'ERROR: User #{@user.email} can\'t be deleted.'
		end
	end

end
