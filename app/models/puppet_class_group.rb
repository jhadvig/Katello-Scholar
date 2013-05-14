class PuppetClassGroup < ActiveRecord::Base
  attr_accessible :name

  has_many :puppet_classes, :dependent => :delete_all

  validates :name, :uniqueness => true

end
