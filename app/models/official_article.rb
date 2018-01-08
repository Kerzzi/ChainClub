class OfficialArticle < ApplicationRecord
  mount_uploader :image, OfficialArticleImageUploader
  
  has_paper_trail
  validates :title, presence: true
  validates :content, presence: true
  
  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS
  
  has_many :article_comments, dependent: :destroy
  belongs_to :article_category, :optional => true
  belongs_to :user
  
  has_many :official_article_relationships                   # 收藏文章关系
  has_many :fans, through: :official_article_relationships, source: :user
  
  def to_param
    "#{self.id}-#{self.title}"
  end
  
end
