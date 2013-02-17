class Lesson < ActiveRecord::Base
  attr_accessible :info, :number, :status

  belongs_to :seminar
  belongs_to :template
end
