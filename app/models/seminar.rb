class Seminar < ActiveRecord::Base
  attr_accessible :day, :ends_at, :info, :seminar_number, :starts_at

  belongs_to :course
end
