class UsersController < SecureController

	layout 'katello-scholar'

	def index

		@admins=Role.find_by_name(:admin).users
		@lectors=Role.find_by_name(:lector).users
		@students=Role.find_by_name(:student).users

	end

	def edit
		@user = User.find(params[:id])
		puts @user
		render "devise/registrations/edit"
	end

	def update
		@user = User.find(params[:id])
		if  @user.valid_password?(params[:user][:current_password])
			params[:user].delete(:current_password)
			if @user.update_attributes(params[:user])
				flash[:success] = "#{@user.email} password was successfully updated"
			else
			    flash[:error] = "#{@user.email} password can\'t be updated"
			end
			redirect_to users_path
		else
			flash[:error] = 'Invalid current password'
			redirect_to users_path
		end
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
