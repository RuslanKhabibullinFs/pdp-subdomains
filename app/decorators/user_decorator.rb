class UserDecorator < ApplicationDecorator
  delegate :id, :first_name, :last_name, :email, :rating, :posts_count, :persisted?

  def posts_count
    object.posts.size
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
