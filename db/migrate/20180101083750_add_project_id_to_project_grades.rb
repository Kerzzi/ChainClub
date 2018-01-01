class AddProjectIdToProjectGrades < ActiveRecord::Migration[5.1]
  def change
    add_column :project_grades, :project_id, :integer
  end
  add_index :project_grades, :project_id
end
