require "rails_helper"

describe User, type: :model do
  subject(:user) { described_class.new(attributes_for(:user)) }

  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:company) }
  it { is_expected.to respond_to(:companies) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:company_id) }
end
