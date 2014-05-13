class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates_presence_of :name, :date, :start_time, :end_time, :user
end
