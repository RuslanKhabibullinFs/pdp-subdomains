require "rails_helper"

feature "Destroy Post" do
  include_context "current user signed in"

  background do
    create(:post, user: current_user, company: current_company)

    visit_company(current_company)
  end

  scenario "Author destroy post" do
    click_link("Delete")

    expect(page).to have_content "successfully destroyed"
  end
end
