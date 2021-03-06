class Course < ActiveRecord::Base

  STATUS = {"Active"=>true,"Inactive"=>false}

  attr_accessible :code, :name, :status, :foreman_id

  has_many :seminars, :dependent => :delete_all
  has_many :templates, :dependent => :delete_all

  validates :code, :presence => true, :length => { :minimum => 3, :maximum => 10} # :uniqueness => { :scope => :year, :message => "should happen once per year" }
  validates :name, :presence => true, :length => { :minimum => 3, :maximum => 50}

  before_create :create_env
  before_destroy :destroy_env#,:can_destroy? 
  before_update :update_env

  def can_destroy?
  	self.status == false ? true : false
  end

  def course_code_name
    "#{self.code}: #{self.name}"
  end

  def activate_course
    self.status = true
  end

  def deactivate_course
    self.status = false
  end

  def create_env
    self.foreman_id = Resources::Foreman::Environment.create(:environment => {:name => self.code.gsub(" ","_")}).first["environment"]["id"] 
  rescue
    false
  end

  def destroy_env
    puts "before"
    Resources::Foreman::Environment.destroy("id"=> self.foreman_id)
  rescue
    puts "false"
    false
  end

  def update_env
    Resources::Foreman::Environment.update("id" => self.foreman_id, :environment => {:name => self.code.gsub(" ","_")})
  rescue
    false
  end

end
