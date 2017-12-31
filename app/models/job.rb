class Job < ApplicationRecord
  validates :title, presence: true
  validates :city, presence: true
  validates :publisher, presence: true
  validates :introduce presence: true
  validates :demand, presence: true
  validates :deadline, presence: true
  validates :process presence: true

  belongs_to :user
end
