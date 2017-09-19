class UsersController < ApplicationController
  expose :filtered_users, -> { UsersFilterQuery.new(current_company.users, filter_params).all }
  expose_decorated :users, -> { founded_users }

  def index
  end

  private

  def founded_users
    @founded_users ||= params[:search].present? ? filtered_users.search(params[:search]) : filtered_users
  end

  def filter_params
    params.permit(:filter_by_rating, sort_by: %i[option order])
  end
end
