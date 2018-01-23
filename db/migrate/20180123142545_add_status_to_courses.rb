class AddStatusToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :status, :string, :default => "draft"
  end
end
