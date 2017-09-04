require "rails_helper"

describe UsersFilterQuery do
  subject(:query) { described_class.new(User.all, filter_params) }

  let!(:popular_user) { create :user, posts_count: 2, rating: 4 }
  let!(:another_popular_user) { create :user, posts_count: 3, rating: 4 }
  let!(:less_popular_user) { create :user, posts_count: 1, rating: 3 }
  let!(:unpopular_user) { create :user, posts_count: 1, rating: 2.5 }

  describe "#all" do
    context "without params" do
      let(:filter_params) { {} }

      it "returns all users sorted by rating" do
        expect(query.all).to eq([popular_user, another_popular_user, less_popular_user, unpopular_user])
      end
    end

    context "with rating filter params" do
      let(:filter_params) { { "filter_by_rating" => 4 } }

      it "returns only users with expected rating" do
        expect(query.all).to eq([popular_user, another_popular_user])
      end
    end

    context "with descending rating sorting params" do
      let(:filter_params) { { "sort_by" => { "option" => "rating", "order" => "desc" } } }

      it "returns users by rating" do
        expect(query.all).to eq([popular_user, another_popular_user, less_popular_user, unpopular_user])
      end
    end

    context "with ascending rating sorting params" do
      let(:filter_params) { { "sort_by" => { "option" => "rating", "order" => "asc" } } }

      it "returns users by rating" do
        expect(query.all).to eq([unpopular_user, less_popular_user, popular_user, another_popular_user])
      end
    end

    context "with descending posts sorting params" do
      let(:filter_params) { { sort_by: { option: :posts, order: :desc } } }

      it "returns users by rating" do
        expect(query.all).to match_array([another_popular_user, popular_user, less_popular_user, unpopular_user])
      end
    end

    context "with ascending posts sorting params" do
      let(:filter_params) { { sort_by: { option: :posts, order: :asc } } }

      it "returns users by rating" do
        expect(query.all).to match_array([unpopular_user, less_popular_user, popular_user, another_popular_user])
      end
    end

    context "with combained filter and sorting" do
      let(:filter_params) { { "filter_by_rating" => 4, "sort_by" => { "option" => "posts", "order" => "desc" } } }

      it "returns users filtered by rating and sorted by posts" do
        expect(query.all).to eq([another_popular_user, popular_user])
      end
    end
  end
end
