class CreateMeetupGroupRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :meetup_group_relationships do |t|
      t.integer :meetup_group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
