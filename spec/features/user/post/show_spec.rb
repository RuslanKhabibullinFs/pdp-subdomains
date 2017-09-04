require "rails_helper"

feature "Show post by company user" do
  include_context "current user signed in"

  let(:user) { create(:user, company: current_company) }
  let(:post) do
    create(:post,
      user: user,
      company: current_company,
      title: "Company super post",
      content: "Very userful post")
  end

  background { visit_company(current_company, post_path(post)) }

  scenario "Another user see post" do
    expect(page).to have_content "Company super post"
    expect(page).to have_content "Very userful post"
  end
end
