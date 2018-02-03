class CreateMeetupComments < ActiveRecord::Migration[5.1]
  def change
    create_table :meetup_comments do |t|
      t.text :content
      t.integer :meetup_group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
