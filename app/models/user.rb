class User < ApplicationRecord
  include PgSearch

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, request_keys: %i[subdomain]

  has_many :posts, dependent: :destroy
  has_many :ratings, dependent: :destroy
  belongs_to :company, optional: true

  validates :email, presence: true,
                    format: { with: Devise.email_regexp },
                    uniqueness: { scope: :company_id }
  validates :password, presence: true, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password, length: { in: Devise.password_length }, allow_blank: true

  validates :first_name, :last_name, presence: true

  pg_search_scope :search, against: %i[first_name last_name email],
                           using: {
                             trigram: {
                               threshold: 0.2
                             }
                           }

  def self.find_for_authentication(warden_conditions)
    company = Company.find_by(subdomain: warden_conditions[:subdomain])
    find_by(email: warden_conditions[:email], company: company)
  end

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
