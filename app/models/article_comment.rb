class ArticleComment < ApplicationRecord
  belongs_to :user
  belongs_to :official_article
end
