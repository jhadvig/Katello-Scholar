class SecureController < ApplicationController

	before_filter :authenticate_user!
	before_filter :user_is
	before_filter :current_ability

	# before_filter :controller_auth

	# def controller_auth
	# 	if ["Lesson","Template","Seminar"].include?(params[:controller].singularize.capitalize)
	# 		if ["index","show"].include?(params[:action]) 
	# 			puts params[:controller].singularize.capitalize
	# 			puts "!!!!!!!!!!!!"
	# 			read_auth(params[:controller].singularize.capitalize)
	# 		else
	# 			puts "????????????"
	# 			manage_auth(params[:controller].singularize.capitalize)
	# 		end
	# 	end
	# end

	# def read_auth(controller)
	# 	unless can?(:read, controller)
	# 		flash[:error] = 'You don\'t have the permission to do this action'
	# 	  	redirect_to :back
	# 	end
	# end

	# def manage_auth(controller)
	# 	unless can?(:manage, controller)
	# 		flash[:error] = 'You don\'t have the permission to do this action'
	# 	  	redirect_to :back
	# 	end
	# end

	layout 'katello-scholar'

	def user_is
		puts current_user.inspect
		puts current_user.roles.inspect
	end

	def current_ability
		@current_ability ||= Ability.new(current_user)
	end

end