class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.date :ico_start
      t.date :ico_end
      t.string :ico_url
      t.string :website
      t.string :slack
      t.string :facebook
      t.string :telegram
      t.string :twitter
      t.string :weibo
      t.string :github
      t.string :whitepaper
      t.integer :ico_amount
      t.integer :token_amount
      t.integer :raised_ceiling
      t.string :accept_token
      t.string :token_type
      t.text :introduce
      t.text :rating_report
      t.decimal :grade
      t.integer :user_id

      t.timestamps
    end
    add_index :projects, :user_id
    add_index :projects, :title
  end
end
