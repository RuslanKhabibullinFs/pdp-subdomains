require "rails_helper"

feature "Update post" do
  include_context "current user signed in"

  let(:post) { create(:post, user: current_user, company: current_company) }

  background { visit_company(current_company, edit_post_path(post)) }

  scenario "Author update post with invalid data" do
    fill_form(:post, :edit, title: "")
    click_button "Update Post"

    expect(page).to have_content "problems"
  end

  scenario "Author update post with valid data" do
    fill_form(:post, :edit, title: "newTitle")
    click_button "Update Post"

    expect(page).to have_content "successfully updated"
  end
end
