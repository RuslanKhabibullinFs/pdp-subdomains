module Ratings
  class CreateRating
    include Interactor

    delegate :user, :post, :rating_params, to: :context

    def call
      context.rating = user.ratings.build(post: post, rating: rating_value)
      context.fail! unless context.rating.save
    end

    private

    def rating_value
      rating_params[:rating]
    end
  end
end
