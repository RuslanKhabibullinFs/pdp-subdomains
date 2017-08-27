class RatingsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  expose :post, scope: -> { current_company.posts }

  def create
    rating = Ratings::Create.call(post: post, user: current_user, rating_params: rating_params).rating
    respond_with rating, location: post_url(post)
  end

  private

  def rating_params
    params.require(:rating).permit(:rating)
  end
end
