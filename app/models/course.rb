class Course < ActiveRecord::Base

  STATUS = {"Active"=>true,"Inactive"=>false}

  attr_accessible :code, :name, :status, :seminars_count

  has_many :seminars, :dependent => :delete_all
  has_many :templates, :dependent => :delete_all

  validates :code, :presence => true, :length => { :minimum => 3, :maximum => 10} # :uniqueness => { :scope => :year, :message => "should happen once per year" }
  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 50}
  validates :seminars_count, :numericality => { :only_integer => true}

  def can_destroy?
  	self.status == false ? true : false
  end

end
