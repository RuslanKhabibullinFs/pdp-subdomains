class PostsController < ApplicationController
  before_action :authenticate_user!

  expose :posts, from: :current_company

  def index
  end
end
