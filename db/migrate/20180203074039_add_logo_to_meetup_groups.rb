class AddLogoToMeetupGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :meetup_groups, :logo, :string
  end
end
