module ApplicationHelper

	def os_icon(os_family,name)
		case os_family

		when "Archlinux"
			"Archlinux.png"

		when "Debian"
			case name
			
			when "Debian"
				"Debian.png"
			when "Ubuntu"
				"Ubuntu.png"
			end				

		when "Redhat"
			case name

			when "RHEL"
				"Redhat.png"

			when "Fedora"
				"Fedora.png"

			when "CentOS"
				"Centos.png"

			when "Scientific", "SL", "Scientific Linux"
				"Scientific.png"

			else
				"Redhat.png"
			end

		when "Solaris"
			"Solaris.png"

		when "Suse"
			"Suse.png"

		when "Windows"
			"Windows.png"
		end
	end

end
