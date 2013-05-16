class Repository < ActiveRecord::Base
  attr_accessible :name, :url

  #has_and_belongs_to_many :templates

  validates :name, :presence => true, :uniqueness => true
  validates :url, :presence => true, :uniqueness => true
end
