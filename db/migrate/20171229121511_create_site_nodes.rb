class CreateSiteNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :site_nodes do |t|
      t.string :name
      t.integer :sort, default: 0

      t.timestamps
    end
    add_index :site_nodes, :sort
  end
end
