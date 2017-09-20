class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, :post_id, :score, presence: true
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :post_id }
end
