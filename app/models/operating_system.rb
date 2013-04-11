class OperatingSystem < ActiveRecord::Base

  OS_FAMILY = ["Archlinux","Debian","RedHat","Solaris","Suse","Windows"]

  attr_accessible :major, :minor, :name, :path

  belongs_to :architecture

  validates :name, :presence => true
  validates :path, :presence => true
  validates :major, :presence => true, :numericality => { :only_integer => true}
  validates :minor, :presence => true, :numericality => { :only_integer => true}
  validates :architecture_id, :presence => true

end
