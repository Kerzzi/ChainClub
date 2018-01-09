class CreatePostComments < ActiveRecord::Migration[5.1]
  def change
    create_table :post_comments do |t|
      t.text :content
      t.integer :post_id
      t.integer :user_id
      t.boolean  :is_hidden,   default: false

      t.timestamps
    end
    add_index :post_comments, :user_id
  end
end
