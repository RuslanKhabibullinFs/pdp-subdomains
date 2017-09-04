require "rails_helper"

feature "Company auth spec" do
  include_context "current user signed in"

  let(:another_company) { create :company }
  let(:current_subdomain) { current_company.subdomain }

  scenario "User get access to signed in company" do
    visit_company(current_company)

    expect(page).to have_content "Log out"
  end

  scenario "User can't get access to unsigned company" do
    visit_company(another_company)

    expect(page).to have_content "Log in to #{another_company.name}"
    expect(page).not_to have_content "Log out"
  end
end
