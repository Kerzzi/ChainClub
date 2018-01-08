class AddSomeDetialsToOfficialArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :official_articles, :image, :string
    add_column :official_articles, :summary, :string
    add_column :users, :summary, :string
  end
end
