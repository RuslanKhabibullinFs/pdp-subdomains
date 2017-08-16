require "rails_helper"

describe CompanyRegistrationForm do
  subject(:company_registration_form) do
    described_class.new(
      email: "owner@email.com",
      first_name: "John",
      last_name: "Snow",
      password: "123456",
      password_confirmation: "123456",
      company_name: "TestCompany",
      company_subdomain: "test_company"
    )
  end

  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:company_name) }
  it { is_expected.to respond_to(:company_subdomain) }

  it { is_expected.to be_valid }

  describe "password" do
    context "when confirmation mismatch" do
      before { company_registration_form.password_confirmation = "mismatch" }

      it { is_expected.not_to be_valid }
    end
  end

  describe "company_name" do
    context "when company with same name already exists" do
      before { create :company, name: "TestCompany" }

      it { is_expected.not_to be_valid }
    end
  end

  describe "company_subdomain" do
    context "when invalid subdomain" do
      before { company_registration_form.company_subdomain = "InvalidSubdomain" }

      it { is_expected.not_to be_valid }
    end

    context "when subdomain already exists" do
      before { create :company, subdomain: "test_company" }

      it { is_expected.not_to be_valid }
    end
  end

  describe "save" do
    context "when is invalid" do
      before { company_registration_form.password_confirmation = "mismatch" }

      it { expect(company_registration_form.save).to be_falsey }
    end

    context "when exception raise during transaction" do
      before { allow(User).to receive(:create!).and_raise(ActiveRecord::RecordInvalid) }

      it { expect(company_registration_form.save).to be_falsey }
    end
  end
end
