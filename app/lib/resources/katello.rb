module Resources

	module katello

	def self.options
    	options = { :base_url => 'https://192.168.122.91/katello/api',
                  :oauth => {
                  :consumer_key => 'foreman',
                  :consumer_secret => 'lCWByXWHdZQnnw3XeDvZHkmfk9lH4lQ/' #245
                  #:consumer_secret => 'NIqxio58Wchhsom3sS4FPKIFoJ8mbEzg' #91
                  }
                }

  end
 
  Environment 	  = KatelloApi::Resources::Environment.new options
  Organization    = KatelloApi::Resources::Organization.new options
  Provider        = KatelloApi::Resources::Provider.new options
  Product         = KatelloApi::Resources::Product.new options


	end
end