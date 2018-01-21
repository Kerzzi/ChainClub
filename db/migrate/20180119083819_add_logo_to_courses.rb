class AddLogoToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :logo, :string
  end
end
