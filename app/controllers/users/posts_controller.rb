module Users
  class PostsController < ApplicationController
    respond_to :json, only: :show

    expose :user, parent: :current_company
    expose_decorated :posts, from: :user

    def index
    end
  end
end
