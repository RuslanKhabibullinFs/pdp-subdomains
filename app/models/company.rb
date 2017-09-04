class Company < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :users
  has_many :posts

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true
end
