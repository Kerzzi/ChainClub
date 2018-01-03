class Section < ApplicationRecord
  has_paper_trail
  
  has_many :nodes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  default_scope -> { order(sort: :desc) }
end
