class RenameRatingField < ActiveRecord::Migration[5.1]
  def change
    rename_column :ratings, :rating, :score
  end
end
