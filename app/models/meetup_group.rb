class MeetupGroup < ApplicationRecord
  mount_uploader :logo, MeetupGroupLogoUploader

  has_paper_trail
  belongs_to :user
  has_many :meetup_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :meetup_type, presence: true
  validates :time_limit, presence: true
  validates :activity_time, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :register, presence: true
  validates :introduce, presence: true
  validates :logo, presence: true

  MEETUPTYPES = ["online", "offline"]
  validates_inclusion_of :meetup_type, :in => MEETUPTYPES

  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  # Scope #
  scope :online_meetup, -> { where(:meetup_type => "online")}
  scope :offline_meetup, -> { where(:meetup_type => "offline")}
  scope :published, -> { where(:status => "public")}
end
