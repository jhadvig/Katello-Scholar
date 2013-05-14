class PuppetClass < ActiveRecord::Base
  attr_accessible :foreman_id, :name, :puppet_class_group_id

  belongs_to :puppet_class_group
  has_and_belongs_to_many :templates

  validates :name, :uniqueness => true
end
