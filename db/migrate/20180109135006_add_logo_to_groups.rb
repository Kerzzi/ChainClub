class AddLogoToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :logo, :string
  end
end
