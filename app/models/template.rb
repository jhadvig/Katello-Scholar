class Template < ActiveRecord::Base
  attr_accessible :name, :info, :operating_system_id, :foreman_puppet_ids
  serialize :foreman_puppet_ids

  belongs_to :course
  has_many :lessons
  has_and_belongs_to_many :puppet_classes
  has_and_belongs_to_many :repository_groups
  belongs_to :operating_system

  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 50}
  validates :operating_system_id, :presence => true
end
