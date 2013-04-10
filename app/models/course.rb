class Course < ActiveRecord::Base

  STATUS = {"Active"=>true,"Inactive"=>false}

  attr_accessible :code, :name, :status, :seminars_count

  has_many :seminars, :dependent => :delete_all
  has_many :templates, :dependent => :delete_all

  validates :code, :presence => true, :length => { :minimum => 3, :maximum => 10} # :uniqueness => { :scope => :year, :message => "should happen once per year" }
  validates :name, :presence => true, :length => { :minimum => 3, :maximum => 50}

  #validates :seminars_count, :numericality => { :only_integer => true}

  before_create :create_env
  before_destroy :destroy_env
  before_update :update_env

  def can_destroy?
  	self.status == false ? true : false
  end

  def course_code_name
    "#{self.code} : #{self.name}"
  end

  def create_env
    self.foreman_id = Resources::Foreman::Environment.create(:environment => {:name => self.name.to_s}).first["environment"]["id"]    
  rescue
    false
  end

  def destroy_env
    Resources::Foreman::Environment.destroy("id"=> self.foreman_id)
  rescue
    false
  end

  def update_env
    Resources::Foreman::Environment.update("id" => self.foreman_id, :environment => {:name => self.name.to_s})
  rescue
    false
  end

end
