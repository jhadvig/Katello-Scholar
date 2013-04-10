class Architecture < ActiveRecord::Base
  attr_accessible :foreman_id, :name

  validates :name, :presence =>true
  validates_uniqueness_of :name, :case_sensitive => false

end
