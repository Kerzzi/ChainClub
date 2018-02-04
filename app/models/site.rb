class Site < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true
  
  belongs_to :site_node, :optional => true
  
  scope :recent, -> { order("created_at DESC")}
end
