require "rails_helper"

feature "Sign in" do
  let!(:company) { create(:company, subdomain: "test") }
  let!(:wrong_company) { create(:company, subdomain: "wrong") }
  let(:user) { create(:user, company: company) }

  scenario "Visitor sign in to wrong company" do
    visit_company wrong_company
    fill_form(:user, email: user.email, password: user.password)
    click_button "Log in"

    expect(page).to have_content "Invalid"
  end

  scenario "Visitor sign in with valid data" do
    visit_company(company)
    fill_form(:user, email: user.email, password: user.password)
    click_button "Log in"

    expect(page).to have_content "Signed in"
  end
end
