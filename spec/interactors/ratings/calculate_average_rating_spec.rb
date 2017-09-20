require "rails_helper"

describe Ratings::CalculateAverageRating do
  let(:interactor) { described_class.new(post: post) }
  let(:user) { create :user }
  let(:post) { create :post, user: user }

  before do
    create :rating, post: post, score: 4
    create :rating, post: post, score: 3
  end

  it "update average rating based on ratings" do
    interactor.run

    expect(post.reload.average_rating).to eq 3.5
    expect(user.reload.rating).to eq 3.5
  end
end
