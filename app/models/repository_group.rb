class RepositoryGroup < ActiveRecord::Base
  attr_accessible :name

  #has_and_belongs_to_many :templates
  has_many :repositories, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true



end
