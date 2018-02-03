class CreateCourseComments < ActiveRecord::Migration[5.1]
  def change
    create_table :course_comments do |t|
      t.text :content
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end
end
