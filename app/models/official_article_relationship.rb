class OfficialArticleRelationship < ApplicationRecord
  belongs_to :official_article
  belongs_to :user
end
