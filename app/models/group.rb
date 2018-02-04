class Group < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :description, presence: true
  validates :logo, presence: true

  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :group_relationships
  has_many :members, through: :group_relationships, source: :user

  mount_uploader :logo,GroupLogoUploader

  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS
  # Scope #
  scope :random5, -> { limit(5).order("RANDOM()") }
  scope :published, -> { where(:status => "public")}
  scope :recent, -> { order("created_at DESC")}
end
