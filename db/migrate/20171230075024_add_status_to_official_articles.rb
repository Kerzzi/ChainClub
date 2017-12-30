class AddStatusToOfficialArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :official_articles, :status, :string, :default => "draft"
  end
end
