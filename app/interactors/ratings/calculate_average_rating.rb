module Ratings
  class CalculateAverageRating
    include Interactor

    delegate :post, to: :context
    delegate :user, to: :post, prefix: true

    def call
      ActiveRecord::Base.transaction do
        post.update!(average_rating: post_average_rating)
        post_user.update!(rating: user_posts_rating)
      end
    rescue ActiveRecord::ActiveRecordError
      context.fail!
    end

    private

    def user_posts_rating
      @user_posts_rating ||= post_user.posts.average(:average_rating)
    end

    def post_average_rating
      @post_average_rating ||= post.ratings.average(:score)
    end
  end
end
