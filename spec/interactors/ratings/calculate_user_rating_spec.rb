require "rails_helper"

describe Ratings::CalculateUserRating do
  let(:interactor) { described_class.new(post: post) }

  let(:user) { create :user }
  let(:post) { create :post, user: user, average_rating: 3 }
  let!(:another_post) { create :post, user: user, average_rating: 4 }

  it "update user rating based on post ratings" do
    interactor.run

    expect(user.reload.rating).to eq 3.5
  end
end
