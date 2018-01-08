class CreateTopicRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :topic_relationships do |t|
      t.integer :topic_id
      t.integer :user_id

      t.timestamps
    end
  end
end
