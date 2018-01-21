class AddQuantityToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :quantity, :integer
  end
end
