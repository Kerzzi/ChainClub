class Topic < ApplicationRecord
  validates :title, presence: true
  has_many :answers
  belongs_to :user
end
