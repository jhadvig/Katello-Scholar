class Role < ActiveRecord::Base
  attr_accessible :name, :value
  has_and_belongs_to_many :users

  def self.index(name)
    where(:name=>name).first.value
  end
end
