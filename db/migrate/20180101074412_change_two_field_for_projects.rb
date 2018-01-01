class ChangeTwoFieldForProjects < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :ico_amount, :string
    change_column :projects, :token_amount, :string
    change_column :projects, :raised_ceiling, :string
    remove_column :projects, :rating_report
  end
end
