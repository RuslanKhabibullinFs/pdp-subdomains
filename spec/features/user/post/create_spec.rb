require "rails_helper"

feature "Create post" do
  include_context "current user signed in"

  let(:post_attributes) { attributes_for(:post) }

  background { visit_company(current_company, new_post_path) }

  scenario "User create post with invalid data" do
    fill_form(:post, post_attributes.except(:title))
    click_button "Create Post"

    expect(page).to have_content "problems"
  end

  scenario "User create post with valid data" do
    fill_form(:article, post_attributes)
    click_button "Create Post"

    expect(page).to have_content "successfully created"
  end
end
