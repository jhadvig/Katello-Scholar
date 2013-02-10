class SecureController < ApplicationController

	before_filter :authenticate_user!

	layout 'katello-scholar'

end