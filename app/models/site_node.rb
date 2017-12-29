class SiteNode < ApplicationRecord
  validates :name, presence: true
  validates :sort, presence: true
  
  has_many :sites
end
