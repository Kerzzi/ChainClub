class Answer < ApplicationRecord
  has_paper_trail
  
  validates :content, presence: true
  
  belongs_to :user
  belongs_to :topic
  
end
