class OperatingSystem < ActiveRecord::Base

  OS_FAMILY = ["Archlinux","Debian","Redhat","Solaris","Suse","Windows"]

  attr_accessible :major, :minor, :name, :path, :architecture_id, :os_family, :foreman_medium_id, :foreman_os_id

  belongs_to :architecture

  validates :name, :presence => true # unique in foreman Medium model
  validates :path, :presence => true, :uniqueness => true
  validates :major, :presence => true#, :numericality => { :only_integer => true}
  validates :minor, :presence => true#, :numericality => { :only_integer => true}
  validates :architecture_id, :presence => true

  # Foreman resources created:-Medium
  #                           -Operating system

  before_create :create_resources
  before_destroy :destroy_resources
  before_update :update_resources

  def create_resources
    puts self.foreman_medium_id.inspect

  	self.foreman_medium_id = Resources::Foreman::Base.http_call('post', '/api/media/', :medium =>  {:name => "#{self.name} #{self.major}.#{self.minor}",
                                                                                                    :path => self.path,
                                                                                                    :os_family => self.os_family}).first["medium"]["id"].to_i

  	foreman_architecture_id = Architecture.find(self.architecture_id).foreman_id

  	ptable_id = Resources::Foreman::Ptable.index(:search => "name ~ RedHat").first.first["ptable"]["id"]

    self.foreman_os_id = Resources::Foreman::OperatingSystem.create(:operatingsystem => {:name => self.name,
                                                                                         :major => self.major,
                                                                                         :minor => self.minor,
                                                                                         :family=> self.os_family, 
                                                                                         :ptable_ids => [ptable_id],
                                                                                         :medium_ids => [self.foreman_medium_id], 
                                                                                         :architecture_ids=> [foreman_architecture_id]}).first["operatingsystem"]["id"]

  rescue
    false
  end

  def destroy_resources

    Resources::Foreman::Base.http_call('delete', "/api/media/#{self.foreman_medium_id}")
    Resources::Foreman::OperatingSystem.destroy("id" => self.foreman_os_id)

  rescue
    false
  end

  def update_resources
    self.foreman_medium_id = Resources::Foreman::Base.http_call('put', "/api/media/#{self.foreman_medium_id}", :medium =>  {:path => self.path}).first["medium"]["id"].to_i
  rescue
    false
  end

end
