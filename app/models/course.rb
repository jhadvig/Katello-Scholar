class Course < ActiveRecord::Base

  STATUS = {"Active"=>true,"Inactive"=>false}

  attr_accessible :code, :name, :status, :seminars_count

  validates :code, :presence => true
  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 50}
  validates :seminars_count, :numericality => { :only_integer => true}
end
