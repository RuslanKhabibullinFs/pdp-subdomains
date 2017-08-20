class UserDecorator < ApplicationDecorator
  delegate :id, :first_name, :last_name, :email, :persisted?

  def posts_count
    object.posts.count
  end
end
