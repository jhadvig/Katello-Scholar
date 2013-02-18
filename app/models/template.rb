class Template < ActiveRecord::Base
  attr_accessible :name, :info

  belongs_to :course
  has_many :lessons

  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 50}
end
