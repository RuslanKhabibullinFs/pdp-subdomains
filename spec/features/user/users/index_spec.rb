require "rails_helper"

feature "Show current company users" do
  include_context "current user signed in"

  def search(term)
    fill_in "search", with: term
    click_button "search"
  end

  def choose_order(order)
    select order
    click_button "apply"
  end

  shared_examples "filter except popular user" do
    it "contain popular user data on page" do
      within ".user" do
        expect(page).to have_content("Popular Person")
        expect(page).to have_content("Posts: 2")
        expect(page).to have_content("Rating: 3.5")
      end
    end

    it "doesn't contain any other users" do
      expect(page).to have_css(".user", count: 1)
    end
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
      last_name: "Person",
      email: "some_hard_email@email.com"
  end

  background { visit_company(current_company, users_path) }

  scenario "Current user see all company users" do
    expect(popular_user.first_name).to appear_before(less_popular_user.first_name)
    expect(less_popular_user.first_name).to appear_before(unpopular_user.first_name)
  end

  context "when current user filter users by rating" do
    before do
      fill_in "Filter By Rating", with: 3.5
      click_button "apply"
    end

    it_behaves_like "filter except popular user"
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

  context "when user search by last name" do
    before { search "Person" }

    it_behaves_like "filter except popular user"
  end

  context "when user search by email" do
    before { search "some_hard_email@email.com" }

    it_behaves_like "filter except popular user"
  end
end
