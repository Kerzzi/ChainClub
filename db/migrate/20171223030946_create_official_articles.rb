class CreateOfficialArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :official_articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :source

      t.timestamps
    end
  end
end
