module Ratings
  class CalculateUserRating
    include Interactor

    delegate :post, to: :context
    delegate :user, to: :post, prefix: true

    def call
      context.fail! unless post_user.update(rating: posts_rating)
    end

    private

    def posts_rating
      @posts_rating ||= Post.where(user: post_user).average(:average_rating)
    end
  end
end
