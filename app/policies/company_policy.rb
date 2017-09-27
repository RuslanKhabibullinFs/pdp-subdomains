class CompanyPolicy < ApplicationPolicy
  def manage?
    record.owner == user
  end
end
