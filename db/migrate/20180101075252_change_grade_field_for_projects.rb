class ChangeGradeFieldForProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :grade
  end
end
