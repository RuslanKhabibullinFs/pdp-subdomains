require "rails_helper"

feature "Sign up" do
  let!(:company) { create(:company) }
  let(:user_attributes) { attributes_for(:user) }

  background { visit_company(company, new_user_registration_path) }

  scenario "Visitor sign up with invalid data" do
    fill_form(:user, user_attributes.except(:password_confirmation))
    click_button "Sign up"

    expect(page).to have_content "problems"
  end

  scenario "Visitor sign up with valid data" do
    fill_form(:user, user_attributes)
    click_button "Sign up"

    expect(page).to have_content("signed up")
  end
end
