class OfficialArticle < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  
  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS
  
  has_many :article_comments, dependent: :destroy
  belongs_to :article_category, :optional => true
  
  def to_param
    "#{self.id}-#{self.title}"
  end
end
