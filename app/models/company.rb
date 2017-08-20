class Company < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true
end
