class Company < ApplicationRecord
  belongs_to :owner, class_name: "User", optional: true
  has_many :users
  has_many :posts, dependent: :destroy

  COMPANY_SUBDOMAIN_REGEXP = /\A[a-z0-9_]+\z/

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true,
                        format: { with: COMPANY_SUBDOMAIN_REGEXP },
                        exclusion: { in: SubdomainConstraint::DEFAULT_SUBDOMAINS }
end
