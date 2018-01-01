class CreateProjectGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :project_grades do |t|
      t.string :grade
      t.text :rating_report
      t.timestamps
    end
  end
end
