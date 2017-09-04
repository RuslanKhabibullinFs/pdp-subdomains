class Post < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :ratings, dependent: :destroy

  validates :title, :content, presence: true
end
