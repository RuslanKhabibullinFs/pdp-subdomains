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
                                format: { with: COMPANY_SUBDOMAIN_REGEXP },
                                exclusion: { in: Subdomains::Base::DEFAULT_SUBDOMAINS }
  validates :company_name, presence: true
  validates :password, presence: true, length: { in: Devise.password_length }, confirmation: true
  validate :company_unique_fields

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

  def company_unique_fields
    return unless companies_with_same_name.exists?
    errors.add(:company_name, :already_exists)
  end

  def companies_with_same_name
    Company.where("subdomain = ? OR lower(name) = ?", company_subdomain, company_name.downcase)
  end
end
