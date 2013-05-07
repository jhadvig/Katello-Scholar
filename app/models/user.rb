class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :name
  # attr_accessible :title, :body
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :seminars

  def admin?
  	self.roles.include?(Role.find_by_name("admin")) ? true : false
  end

  def lector?
  	self.roles.include?(Role.find_by_name("lector")) ? true : false
  end

  def student?
  	self.roles.include?(Role.find_by_name("student")) ? true : false
  end

  def random_password(size = 8)
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end

  
end
