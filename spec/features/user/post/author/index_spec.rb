require "rails_helper"

feature "Show posts for current company" do
  include_context "current user signed in"

  def have_settings_options
    have_css ".three-dots"
  end

  let(:user) { create :user, company: current_company }

  background do
    create :post, user: current_user, company: current_company, title: "Current user post"
    create :post, user: user, company: current_company, title: "Another user post"
  end

  scenario "Current user see all company posts" do
    visit_company(current_company, posts_path)

    expect(page).to have_content "Current user post"
    expect(page).to have_content "Another user post"
  end

  scenario "Current user see own posts" do
    visit_company(current_company, user_posts_path(current_user))

    expect(page).to have_content "Current user post"
    expect(page).not_to have_content "Another user post"

    within ".component" do
      expect(page).to have_content current_user.first_name
      expect(page).to have_settings_options
    end
  end
end
