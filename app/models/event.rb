class Event < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :date, :start_time, :end_time, :user
end
