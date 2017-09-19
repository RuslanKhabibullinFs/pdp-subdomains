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

  attr_accessor(*ATTRIBUTES)

  def save
    return invalidate_form unless form_valid?

    ActiveRecord::Base.transaction do
      @owner = User.create!(user_params)
      # after create_company! user.company association initialized locally ((
      @company = owner.create_company!(name: company_name, subdomain: company_subdomain, owner: owner)
      owner.save!
    end
  rescue ActiveRecord::ActiveRecordError
    false
  end

  def owner
    @owner ||= User.new(user_params)
  end

  def company
    @company ||= Company.new(name: company_name, subdomain: company_subdomain)
  end

  private

  def invalidate_form
    set_onwer_errors unless owner.valid?
    set_company_errors unless company.valid?

    false
  end

  def set_onwer_errors
    owner.errors.each do |field, error|
      errors.add(field, error)
    end
  end

  def set_company_errors
    company.errors.each do |field, error|
      errors.add("company_#{field}".to_sym, error)
    end
  end

  def form_valid?
    valid? && owner.valid? && company.valid?
  end

  def user_params
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      password_confirmation: password_confirmation
    }
  end
end
