require "rails_helper"

feature "Create Company" do
  let(:company_registration_attributes) do
    attributes_for :company_registration_form, company_subdomain: "test"
  end
  let(:company_name) { company_registration_attributes[:company_name] }

  background { visit new_company_registration_path }

  scenario "Visitor create company with invalid data" do
    fill_form(:company_registration_form, company_registration_attributes.update(password: "mismatch"))
    click_button "Create Company"

    expect(page).to have_content "Please review the problems below"
  end

  scenario "Visitor create company with valid data" do
    fill_form(:company_registration_form, company_registration_attributes)
    click_button "Create Company"

    expect(page).to have_content "Log in to #{company_name}"
  end
end
