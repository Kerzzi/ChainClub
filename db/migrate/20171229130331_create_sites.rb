class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :neme
      t.string :url
      t.string :description
      t.integer :site_node_id
      t.integer :user_id

      t.timestamps
    end
    add_index :sites, :site_node_id
    add_index :sites, :url
  end
end
