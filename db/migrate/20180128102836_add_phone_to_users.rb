class AddPhoneToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :phone, :string
    rename_column :profiles, :introduce, :postal_code
  end
end
