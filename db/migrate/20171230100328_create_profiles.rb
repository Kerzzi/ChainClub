class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id, :index => true
      t.string :name
      t.date :birthday
      t.string :location
      t.string :school
      t.string :education
      t.string :company
      t.string :occupation
      t.string :position
      t.string :address
      t.string :weibo
      t.string :wechat
      t.string :github
      t.integer :qq
      t.text :bio
      t.text :specialty
      t.text :introduce
      
      t.timestamps
    end
  end
end
