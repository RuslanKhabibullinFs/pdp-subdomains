require "rails_helper"

describe Ratings::CalculatePostAverageRating do
  let(:interactor) { described_class.new(post: post) }

  let(:post) { create :post }

  before do
    create :rating, post: post, rating: 4
    create :rating, post: post, rating: 3
  end

  it "update post average rating based on ratings" do
    interactor.run

    expect(post.reload.average_rating).to eq 3.5
  end
end
