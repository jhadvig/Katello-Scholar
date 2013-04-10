class ArchitecturesController < SecureController

	def index
		@architectures = Architecture.all
	end


end