class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_and_belongs_to_many :roles

  def admin?
  	self.roles.include?(Role.find_by_name("admin")) ? true : false
  end

  def lector?
  	self.roles.include?(Role.find_by_name("lector")) ? true : false
  end

  def student?
  	self.roles.include?(Role.find_by_name("student")) ? true : false
  end

  
end
