class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :first_name, :last_name
  validates_presence_of :first_name, :last_name
  has_many :event_participation
  has_many :events
  def name
    [first_name, last_name].join(" ")
  end
end
