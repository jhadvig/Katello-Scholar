class PuppetClassesController < SecureController

	def import
		@puppet_classes = Resources::Foreman::PuppetClass.index.first
		created_puppet_groups = []
		@puppet_classes.each do |all|

			puppet_group = PuppetClassGroup.create(:name => all.first)
			created_puppet_groups << puppet_group.name
			all.last.each do |single|
				PuppetClass.create( :name => single["puppetclass"]["name"].to_s,
									:foreman_id => single["puppetclass"]["id"].to_i,
									:puppet_class_group_id => puppet_group.id )
			end
		end

		flash[:success] = "PuppetClasses: \n#{created_puppet_groups.join("\n")}\n were successfully created"
		redirect_to :back
	# rescue
	# 	flash[:success] = "PuppetClasses could be created"
	# 	redirect_to :back
	end

end