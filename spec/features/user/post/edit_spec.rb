require "rails_helper"

feature "Update post by another user" do
  include_context "current user signed in"

  let(:user) { create(:user, company: current_company) }
  let(:post) { create(:post, user: user, company: current_company) }

  background { visit_company(current_company, edit_post_path(post)) }

  scenario "Another user update post" do
    expect(page).not_to have_content "Edit"
  end
end
