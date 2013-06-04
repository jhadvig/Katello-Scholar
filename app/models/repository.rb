class Repository < ActiveRecord::Base
  attr_accessible :name, :url

  belongs_to :repository_group

  validates :name, :presence => true, :uniqueness => true
  validates :url, :presence => true, :uniqueness => true
end
