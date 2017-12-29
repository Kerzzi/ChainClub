class CreateArticleCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :article_categories do |t|
      t.string :name

      t.timestamps
    end
    
    add_column :official_articles, :article_category_id, :integer
    add_index :official_articles, :article_category_id
  end
end
