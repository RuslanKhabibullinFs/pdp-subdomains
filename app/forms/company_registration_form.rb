class CompanyRegistrationForm
  include ActiveModel::Model

  ATTRIBUTES = %i[
    email
    password
    password_confirmation
    first_name
    last_name
    company_name
    company_subdomain
  ].freeze

  COMPANY_SUBDOMAIN_REGEXP = /\A[a-z0-9_]+\z/

  attr_accessor(*ATTRIBUTES)

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :first_name, :last_name, presence: true
  validates :company_subdomain, presence: true,
                                uniqueness: { model: Company, attribute: "subdomain" },
                                format: { with: COMPANY_SUBDOMAIN_REGEXP },
                                exclusion: { in: Subdomains::Base::DEFAULT_SUBDOMAINS }
  validates :company_name, presence: true,
                           uniqueness: { case_sensitive: false, model: Company, attribute: "name" }
  validates :password, :password_confirmation, presence: true, length: { in: Devise.password_length }
  validate :password_equality_check

  attr_reader :owner, :company

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      @owner = User.create! user_params
      @company = owner.companies.create!(name: company_name, subdomain: company_subdomain)
      owner.update_attributes!(company_id: company.id)
    end
  rescue
    false
  end

  private

  def user_params
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      password_confirmation: password_confirmation
    }
  end

  def password_equality_check
    errors.add(:password, :confirmation_mismatch) unless password == password_confirmation
  end
end
