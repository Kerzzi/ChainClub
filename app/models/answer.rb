class Answer < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :user
  belongs_to :topic
  
  acts_as_commentable
end
