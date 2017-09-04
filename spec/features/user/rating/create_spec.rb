require "rails_helper"

feature "Rate post by company user", js: true do
  include_context "current user signed in"

  let(:post) { create(:post, user: current_user, company: current_company) }

  scenario "User rate the post to 3 points" do
    visit_company(current_company, post_path(post))

    find("label[for='js-rating-#{post.id}-3']").click

    expect(page).to have_content("Rating:3")
    expect(page).to have_content("Thanks for your feedback")
  end

  context "when user already rate same post" do
    before do
      create(:rating, user: current_user, post: post, rating: 2)
      post.update(average_rating: 2)
      visit_company(current_company, post_path(post))
    end

    scenario "User can't rate again same post" do
      expect(page).to have_content("Rating:2")

      within(".js-star-ratings") do
        expect(first("input", visible: false)[:disabled]).to eq "true"
      end
    end
  end
end
