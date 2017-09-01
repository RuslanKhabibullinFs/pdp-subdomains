class Post < ApplicationRecord
  belongs_to :company
  belongs_to :user, counter_cache: true
  has_many :ratings, dependent: :destroy

  validates :title, :content, presence: true
end
