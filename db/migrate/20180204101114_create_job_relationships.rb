class CreateJobRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :job_relationships do |t|
      t.integer :job_id
      t.integer :user_id

      t.timestamps
    end
  end
end
