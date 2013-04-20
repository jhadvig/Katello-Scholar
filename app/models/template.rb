class Template < ActiveRecord::Base
  attr_accessible :name, :info, :operating_system_id

  belongs_to :course
  has_many :lessons
  belongs_to :operating_system

  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 50}
  validates :operating_system_id, :presence => true
end
