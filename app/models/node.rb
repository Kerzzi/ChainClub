class Node < ApplicationRecord
  has_paper_trail
  validates :name, :summary, :section, presence: true
  validates :name, uniqueness: true
  
  has_many :topics
  belongs_to :section

  scope :hots, -> { order(topics_count: :desc) }
  scope :sorted, -> { order(sort: :desc) }
  scope :recent, -> { order("created_at DESC")}

end
