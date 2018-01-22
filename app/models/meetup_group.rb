class MeetupGroup < ApplicationRecord
  has_paper_trail
  belongs_to :user
  validates :title, presence: true
  validates :meetup_type, presence: true
  validates :time_limit, presence: true
  validates :activity_time, presence: true
  validates :city, presence: true
  validates :address, presence: true  
  validates :register, presence: true
  validates :introduce, presence: true  

  MEETUPTYPES = ["online", "offline"]
  validates_inclusion_of :meetup_type, :in => MEETUPTYPES

  # Scope #
  scope :online_meetup, -> { where(:meetup_type => "online")}
  scope :offline_meetup, -> { where(:meetup_type => "offline")}
    
end
