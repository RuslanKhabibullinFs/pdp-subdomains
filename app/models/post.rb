class Post < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :title, :content, presence: true
end