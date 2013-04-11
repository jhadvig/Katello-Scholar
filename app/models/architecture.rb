class Architecture < ActiveRecord::Base
  attr_accessible :foreman_id, :name

  has_many :operating_systems #, :dependent => :delete_all

  validates :name, :presence =>true
  validates_uniqueness_of :name, :case_sensitive => false

end
