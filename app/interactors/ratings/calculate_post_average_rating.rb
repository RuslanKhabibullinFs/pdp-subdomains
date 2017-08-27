module Ratings
  class CalculatePostAverageRating
    include Interactor

    delegate :post, to: :context

    def call
      context.fail! unless post.update(average_rating: average_rating)
    end

    private

    def average_rating
      @average_rating ||= Rating.where(post: post).average(:rating)
    end
  end
end
