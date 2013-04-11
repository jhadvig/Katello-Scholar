class OperatingSystem < ActiveRecord::Base

  OS_FAMILY = ["Archlinux","Debian","RedHat","Solaris","Suse","Windows"]

  attr_accessible :major, :minor, :name, :path, :architecture_id, :os_family

  belongs_to :architecture

  validates :name, :presence => true
  validates :path, :presence => true
  validates :major, :presence => true#, :numericality => { :only_integer => true}
  validates :minor, :presence => true#, :numericality => { :only_integer => true}
  validates :architecture_id, :presence => true

  #before_create :create_resources

  def create_resources

  	medium_id = Resources::Foreman::Base.http_call('post', '/api/media/', :medium => {:name => self.name,
  																  :path => self.path, 
  																  :os_family => self.os_family})

  	arch_id = Resources::Foreman::Architecture.show("id"=>self.architecture_id).first["architecture"]

  	ptable_id = Resources::Foreman::Ptable.index(:search => "name ~ RedHat").first.first["ptable"]


  end



end
