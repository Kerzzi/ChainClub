class CreateArticleComments < ActiveRecord::Migration[5.1]
  def change
    create_table :article_comments do |t|
      t.text :content
      t.integer :official_article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
