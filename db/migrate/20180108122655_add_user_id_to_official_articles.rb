class AddUserIdToOfficialArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :official_articles, :user_id, :integer
  end
end
