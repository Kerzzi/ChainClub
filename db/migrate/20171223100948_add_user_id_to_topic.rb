class AddUserIdToTopic < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :user_id, :integer
  end
end
