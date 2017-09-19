class UsersController < ApplicationController
  expose_decorated :users, -> { UsersFilterQuery.new(current_company.users, filter_params).all }

  def index
  end

  private

  def filter_params
    params.permit(:filter_by_rating, :search, sort_by: %i[option order])
  end
end
