module Admin
  class CompaniesController < Admin::ApplicationController
    # add some before_action that allows only for current company! in policy
    before_action :authenticate_company

    expose(:company)

    private

    def authenticate_company
      return head(:forbidden) unless company.owner == current_user
    end
  end
end
