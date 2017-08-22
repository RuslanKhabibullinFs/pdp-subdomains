class PostPolicy < ApplicationPolicy
  def manage?
    record.user == user
  end
end
