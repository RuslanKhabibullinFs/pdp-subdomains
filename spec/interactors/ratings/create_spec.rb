require "rails_helper"

describe Ratings::Create do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        Ratings::CreateRating,
        Ratings::CalculateAverageRating
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
