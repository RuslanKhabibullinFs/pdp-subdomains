class RatingsController < ApplicationController
  respond_to :json

  expose :post, scope: -> { current_company.posts }

  delegate :rating, to: :rating_creation_context

  def create
    respond_with rating, location: post_url(post)
  end

  private

  def rating_creation_context
    Ratings::Create.call(post: post, user: current_user, rating_params: rating_params)
  end

  def rating_params
    params.require(:rating).permit(:score)
  end
end
