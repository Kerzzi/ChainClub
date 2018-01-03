class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :summary
      t.integer :section_id
      t.integer :sort, default: 0
      t.integer :topics_count, default: 0

      t.timestamps
    end
    add_index :nodes, :section_id
    add_index :nodes, :sort
  end
end
