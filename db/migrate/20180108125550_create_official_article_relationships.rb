class CreateOfficialArticleRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :official_article_relationships do |t|
      t.integer :official_article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
