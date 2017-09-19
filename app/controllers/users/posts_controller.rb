module Users
  class PostsController < ApplicationController
    respond_to :json, only: :show

    expose :user, parent: :current_company
    expose_decorated :posts, -> { user_posts }

    def index
    end

    private

    def user_posts
      @user_posts ||= current_company.posts.where(user: user).includes(:user)
    end
  end
end
