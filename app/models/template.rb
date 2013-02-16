class Template < ActiveRecord::Base
  attr_accessible :name, :info

  belongs_to :course

  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 50}
end
