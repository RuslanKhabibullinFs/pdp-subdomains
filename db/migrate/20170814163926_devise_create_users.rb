class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :first_name,         null: false
      t.string :last_name,          null: false
      t.integer :company_id

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, %i[email company_id], unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :company_id
  end
end
