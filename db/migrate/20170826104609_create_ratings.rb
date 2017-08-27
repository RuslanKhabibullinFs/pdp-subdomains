class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :rating, null: false, default: 0
      t.timestamps
    end

    add_index :ratings, :user_id
    add_index :ratings, :post_id
    add_index :ratings, [:user_id, :post_id], unique: true
  end
end
