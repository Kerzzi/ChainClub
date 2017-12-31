class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.integer :price
      t.integer :msrp
      t.integer :user_id
      t.text :introduce
      t.text :lecturer
      t.string :url

      t.timestamps
    end
    add_index :courses, :user_id
    add_index :courses, :title
  end
end
