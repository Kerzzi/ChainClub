class Answer < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :user
  belongs_to :topic
end
