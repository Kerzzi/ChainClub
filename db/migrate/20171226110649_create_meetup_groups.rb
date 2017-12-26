class CreateMeetupGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :meetup_groups do |t|
      t.string :title
      t.string :type
      t.string :time_limit
      t.string :activity_time
      t.string :city
      t.string :address
      t.string :register
      t.text :introduce
      t.integer :user_id

      t.timestamps
    end
  end
end
