require "rails_helper"

feature "Destroy Post" do
  include_context "current user signed in"

  let!(:post) { create(:post, user: current_user, company: current_company) }

  background { visit_company(current_company) }

  scenario "Author destroy post" do
    click_link("Delete")

    expect(page).to have_content "successfully destroyed"
  end
end
