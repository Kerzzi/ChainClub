class AddSomeDetailsToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :body_html, :text
    add_column :answers, :state, :integer
    add_column :answers, :liked_user_ids, :integer

  end
  add_index :answers, :topic_id
  add_index :answers, :user_id
end
