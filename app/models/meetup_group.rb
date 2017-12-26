class MeetupGroup < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :type, presence: true
  validates :time_limit, presence: true
  validates :activity_time, presence: true
  validates :city, presence: true
  validates :address, presence: true  
  validates :register, presence: true
  validates :introduce, presence: true  
end
