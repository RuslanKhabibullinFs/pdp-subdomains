module Admin
  class ApplicationController < Administrate::ApplicationController
    include Authorization
    include CurrentCompanyExposer

    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
      authorize(current_company, :manage?)
    end

    def index
      render locals: {
        resources: resources,
        search_term: search_term,
        page: Administrate::Page::Collection.new(dashboard, order: order),
        show_search_bar: show_search_bar?
      }
    end

    private

    def resources
      order.apply(base_search).page(params[:page]).per(records_per_page)
    end

    def base_search
      @search_result = Administrate::RelationSearch.new(
        scoped_resource: scoped_resource,
        dashboard_class: dashboard_class,
        term: search_term,
        relation: relation
      ).run
      @search_result.includes(*resource_includes) if resource_includes.any?
    end

    def search_term
      params[:search].to_s.strip
    end

    def show_search_bar?
      false
    end
  end
end
