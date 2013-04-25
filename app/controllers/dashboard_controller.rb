class DashboardController < SecureController

	# before_filter :set_gettext_locale

	# def set_gettext_locale
	# 	puts "KKAAAREEEE"
	#   	I18n.locale = kare
	# end

	def new

	end

	def index
		@courses_count = Course.all.count
		@seminars_count = Seminar.all.count
		@lessons_count = Lesson.all.count
		@template_count = Template.all.count
		@os_count = OperatingSystem.all.count
		@labs_count = Lab.all.count
		@hosts_count = SystemHost.all.count
		@users_count = User.all.count

	end

end