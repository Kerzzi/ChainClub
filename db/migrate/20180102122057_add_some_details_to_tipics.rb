class AddSomeDetailsToTipics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :node_id, :integer
    add_column :topics, :content_html, :text 
    add_column :topics, :last_answer_id, :integer
    add_column :topics, :last_answer_user_id, :integer
    add_column :topics, :node_name, :string
    add_column :topics, :who_deleted, :string
    add_column :topics, :lock_node, :boolean, default: false

    add_column :topics, :answers_count, :integer, default: 0

  end


  add_index :topics, :node_id
  add_index :topics, :user_id
end
