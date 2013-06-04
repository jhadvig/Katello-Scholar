class Repository < ActiveRecord::Base
  attr_accessible :name, :url, :status

  belongs_to :repository_group

  validates :name, :presence => true, :uniqueness => { :scope => :repository_group_id }
  validates :url, :presence => true, :uniqueness => true
end
