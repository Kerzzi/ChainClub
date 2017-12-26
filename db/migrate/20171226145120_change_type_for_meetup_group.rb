class ChangeTypeForMeetupGroup < ActiveRecord::Migration[5.1]
  def change
    rename_column :meetup_groups, :type, :meetup_type
  end
end
