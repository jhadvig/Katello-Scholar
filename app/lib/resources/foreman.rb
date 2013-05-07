module Resources

	module Foreman

	def self.options
      	# @options ||= begin
       #  config = Katello.config.foreman
       #  { :base_url           => config.url,
       #    	:enable_validations => false,
       #    	:oauth              => { :consumer_key    => config.oauth_key,
       #      	                       :consumer_secret => config.oauth_secret },
       #    	:logger             => Logging.logger['foreman_rest'] }
      	# end

      	options = {:base_url => 'https://192.168.122.91/foreman',
                 :username => 'admin',
                 :password => 'changeme'}

    end

    # def self.timeout_options
    #   { :open_timeout => Katello.config.rest_client_timeout,
    #     :timeout      => Katello.config.rest_client_timeout }
    # end

    Base            = ForemanApi::Base.new options
    Architecture    = ForemanApi::Resources::Architecture.new options 
    Environment 	  = ForemanApi::Resources::Environment.new options
    Bookmark        = ForemanApi::Resources::Bookmark.new options
    Home            = ForemanApi::Resources::Home.new options 
    OperatingSystem = ForemanApi::Resources::OperatingSystem.new options 
    User            = ForemanApi::Resources::User.new options 
    Domain          = ForemanApi::Resources::Domain.new options 
    SmartProxy      = ForemanApi::Resources::SmartProxy.new options 
    Subnet          = ForemanApi::Resources::Subnet.new options 
    ConfigTemplate  = ForemanApi::Resources::ConfigTemplate.new options
    ComputeResource = ForemanApi::Resources::ComputeResource.new options
    HardwareModel   = ForemanApi::Resources::Model.new options
    Medium          = ForemanApi::Resources::Medium.new options
    Ptable          = ForemanApi::Resources::Ptable.new options
    Hostgroup       = ForemanApi::Resources::Hostgroup.new options
    Host            = ForemanApi::Resources::Host.new options

	end
end