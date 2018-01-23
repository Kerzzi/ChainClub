class AddStatusToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :status, :string, :default => "draft"
  end
end
