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
  it { is_expected.to respond_to(:owner) }
  it { is_expected.to respond_to(:company) }

  it { is_expected.to be_valid }

  describe "save" do
    context "when is invalid" do
      before { company_registration_form.password_confirmation = "mismatch" }

      it { expect(company_registration_form.save).to be_falsey }
    end

    context "when exception raise during transaction" do
      let(:owner) { company_registration_form.owner }

      before { allow(User).to receive(:create!).and_raise(ActiveRecord::RecordInvalid) }

      it { expect(company_registration_form.save).to be_falsey }
    end

    context "when form is valid" do
      let(:owner) { company_registration_form.owner }

      before { company_registration_form.save }

      it { expect(owner.persisted?).to be_truthy }
      it { expect(owner.company).to be_truthy }
    end
  end
end
