class MeetupComment < ApplicationRecord
  belongs_to :meetup_group
  belongs_to :user  
  
  validates :content, presence: true
  
  scope :recent, -> { order("created_at DESC")}
end
