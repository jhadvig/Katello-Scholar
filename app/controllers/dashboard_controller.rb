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
		@repositories_count = Repository.count
		@repository_group_count = RepositoryGroup.count
		@users_count = User.all.count

		monday,tuesday,wednesday,thursday,friday,weekend,@day_lessons,os_family,@os_family_count = [],[],[],[],[],[],[],[],[]

		Lesson.all.each do |l|
			if l.starts_at.monday?
				monday <<  l
			elsif l.starts_at.tuesday?
				tuesday << l
			elsif l.starts_at.wednesday?
				wednesday << l
			elsif l.starts_at.thursday?
				thursday << l
			elsif l.starts_at.friday?
				friday << l
			else
				weekend << l
			end

			os_family << l.template.operating_system.os_family

		end

		@day_lessons = [monday.count, tuesday.count, wednesday.count, thursday.count, friday.count, weekend.count]

		OperatingSystem::OS_FAMILY.each do |os|
			@os_family_count << os_family.count(os)
		end
		puts "!!!!!!!!!!!!!!!!!!!!!"
		puts @os_family_count[0]

		respond_to do |format|
			format.html
			format.json {
				render :json => {
					:day_lessons => @day_lessons,
					:os_family_count => @os_family_count
				}
			}
		end

	end

end