class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :company_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end

    add_index :posts, :company_id
    add_index :posts, :user_id
  end
end
