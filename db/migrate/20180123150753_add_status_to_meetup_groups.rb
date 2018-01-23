class AddStatusToMeetupGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :meetup_groups, :status, :string, :default => "public"
  end
end
