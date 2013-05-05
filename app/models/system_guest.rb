class SystemGuest < ActiveRecord::Base

	STATUS = {"Provisioning"=>0,"Running"=>1, "Down"=>2}

	attr_accessible :foreman_host_id, :system_host_id, :lesson_id, :name, :url, :status

	belongs_to :lesson
	belongs_to :system_host

	#validates :name, :presence => true
	#validates :url, :presence => true
	#validates :foreman_host_id, :presence => true
  #validates :system_host_id, :presence =>true

  after_create :create_guest

  def self.schedule_provisioning(lesson_id)

    SystemGuest.create( :name => "DJ_TEST",
                        :lesson_id => lesson_id,
                        :status => 0)
    # # dj = Delayed::Job.last
    # # obj = YAML.load(dj.handler)
    # hosts.each do |host|
    #   #SystemGuest.foreman_guest_provision(obj.args.first)
    #   SystemGuest.create( :name => "guest1_#{host.name}",
    #             :lesson_id => lesson_id, 
    #             :system_host_id => host.id, 
    #             :status => 0)
    # end
  end
  #handle_asynchronously :schedule_provisioning, :run_at => Proc.new {10.seconds.from_now}
  #handle_asynchronously :foreman_guest_provision, :run_at => Proc.new {|lecture| lecture.starts_at}


	def self.foreman_guest_provision(lesson_id)#, name)#,host,hostgroup,subnet)
		#self.foreman_host_id 
    SystemGuest.create(:name => "guest1", :lesson_id => lesson_id)
	end
	# handle_asynchronously :foreman_guest_provision, :run_at => Proc.new {|lecture.starts_at|}

	def generate_password
		(0...8).map{(65+rand(26)).chr}.join.downcase
	end

  def create_guest
  end


end
