class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[edit update destroy]

  expose_decorated :posts, from: :current_company
  expose_decorated :post, scope: -> { current_company.posts }

  def index
  end

  def new
  end

  def create
    post.user = current_user
    post.save
    respond_with post
  end

  def show
  end

  def edit
  end

  def update
    post.update_attributes(post_params)
    respond_with post
  end

  def destroy
    post.destroy
    respond_with post, location: root_path
  end

  private

  def authorize_user!
    authorize(post, :manage?)
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
