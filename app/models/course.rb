class Course < ActiveRecord::Base
  attr_accessible :code, :name, :status, :seminars_count

  STATUS = [1,0]
end
