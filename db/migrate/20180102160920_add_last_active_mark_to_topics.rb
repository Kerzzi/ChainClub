class AddLastActiveMarkToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :last_active_mark, :integer
  end
end
