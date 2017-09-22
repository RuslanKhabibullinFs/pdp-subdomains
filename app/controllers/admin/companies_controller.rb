module Admin
  class CompaniesController < Admin::ApplicationController
    before_action :authenticate_company!

    expose(:company)

    private

    def authenticate_company!
      authorize(company, :manage?)
    end
  end
end
