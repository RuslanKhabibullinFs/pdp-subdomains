require "rails_helper"

describe Ratings::CreateRating do
  let(:interactor) { described_class.new(user: user, post: post, rating_params: rating_params) }

  let(:user) { create :user }
  let(:post) { create :post }
  let(:rating_params) { attributes_for :rating, rating: 3 }

  it "build's new rating for user based on post" do
    interactor.run

    expect(user.ratings).not_to be_empty
  end
end
