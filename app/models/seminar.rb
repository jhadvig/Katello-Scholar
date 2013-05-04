class Seminar < ActiveRecord::Base
	attr_accessible :day, :ends_at, :info, :seminar_number, :starts_at, :lab_id, :users

	belongs_to :course
	has_many :lessons, :dependent => :destroy
	belongs_to :lab
	has_and_belongs_to_many :users

	validates :seminar_number, :presence =>true, :numericality => { :only_integer => true }
	validates :day, :presence=>true
	validates :starts_at, :presence=>true
	validates :ends_at, :presence=>true


end
