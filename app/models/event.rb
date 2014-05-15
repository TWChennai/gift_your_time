class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :event_participation, dependent: :destroy
  validates_presence_of :name, :date, :start_time, :end_time, :user
  validate :time_range

  private
  def time_range
    errors.add(:end_time, "should be greater than event start time") if start_time > end_time
  end
end
