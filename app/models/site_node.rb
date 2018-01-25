class SiteNode < ApplicationRecord
  has_paper_trail

  validates :name, presence: true
  validates :sort, presence: true
  
  has_many :sites
end
