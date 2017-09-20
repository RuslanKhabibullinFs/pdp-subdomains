module Ratings
  class CreateRating
    include Interactor

    delegate :user, :post, :rating_params, to: :context

    def call
      context.rating = user.ratings.build(post: post, score: score)
      context.fail! unless context.rating.save
    end

    private

    def score
      rating_params[:score]
    end
  end
end
