class Project < ApplicationRecord
  validates :title, presence: true
  validates :website, presence: true
  validates :whitepaper, presence: true

  belongs_to :user
end
