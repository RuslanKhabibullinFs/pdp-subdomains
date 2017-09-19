class PostsController < ApplicationController
  respond_to :json, only: :show

  before_action :authorize_user!, only: %i[edit update destroy]

  expose :user, id: :user_id, parent: :current_company
  expose_decorated :posts, -> { filtered_posts.includes(:user) }
  expose_decorated :post, scope: -> { posts }

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
    respond_with post
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

  def filtered_posts
    @filtered_posts ||= user.persisted? ? current_company.posts.where(user: user) : current_company.posts
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
