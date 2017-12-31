class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :city
      t.string :publisher
      t.text :benefit
      t.text :introduce
      t.text :demand
      t.date :deadline
      t.text :process
      t.integer :user_id

      t.timestamps
    end
    add_index :jobs, :user_id
  
  end
end
