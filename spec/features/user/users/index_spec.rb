require "rails_helper"

feature "Show current company users" do
  include_context "current user signed in"

  def choose_order(order)
    select order
    click_button "apply"
  end

  let!(:unpopular_user) do
    create :user, :with_posts,
      company: current_company,
      rating: 2.5,
      first_name: "Unpopular",
      last_name: "User"
  end
  let!(:less_popular_user) do
    create :user, :with_posts,
      company: current_company,
      rating: 3,
      first_name: "Lesspopular",
      last_name: "User"
  end
  let!(:popular_user) do
    create :user, :with_posts,
      number_of_posts: 2,
      company: current_company,
      rating: 3.5,
      first_name: "Popular",
      last_name: "User"
  end

  background { visit_company(current_company, users_path) }

  scenario "Current user see all company users" do
    expect(popular_user.first_name).to appear_before(less_popular_user.first_name)
    expect(less_popular_user.first_name).to appear_before(unpopular_user.first_name)
  end

  scenario "Current user filter users by rating" do
    fill_in "Filter By Rating", with: 3.5
    click_button "apply"

    within ".user" do
      expect(page).to have_content("Popular User")
      expect(page).to have_content("Posts: 2")
      expect(page).to have_content("Rating: 3.5")
    end

    expect(page).not_to have_content("LessPopular User")
    expect(page).not_to have_content("Unpopular User")
  end

  context "when order users by rating" do
    before { select "rating" }

    scenario "current user choose descending order" do
      choose_order "desc"

      expect(popular_user.first_name).to appear_before(less_popular_user.first_name)
      expect(less_popular_user.first_name).to appear_before(unpopular_user.first_name)
    end

    scenario "current user choose ascending order" do
      choose_order "asc"

      expect(unpopular_user.first_name).to appear_before(less_popular_user.first_name)
      expect(less_popular_user.first_name).to appear_before(popular_user.first_name)
    end
  end

  context "when order users by posts" do
    before { select "posts" }

    scenario "current user choose descending order" do
      choose_order "desc"

      expect(popular_user.first_name).to appear_before(less_popular_user.first_name)
      expect(less_popular_user.first_name).to appear_before(unpopular_user.first_name)
    end

    scenario "current user choose ascending order" do
      choose_order "asc"

      expect(less_popular_user.first_name).to appear_before(unpopular_user.first_name)
      expect(unpopular_user.first_name).to appear_before(popular_user.first_name)
    end
  end
end
