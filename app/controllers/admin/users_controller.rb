module Admin
  class UsersController < Admin::ApplicationController
    DENIED_ACTIONS = %w[new create edit update].freeze

    expose :relation, -> { User.where(company: current_company) }

    private

    def valid_action?(name, resource = resource_class)
      DENIED_ACTIONS.exclude?(name.to_s) && super
    end

    def show_search_bar?
      true
    end

    def find_resource(id)
      relation.find_by!(id: id)
    end
  end
end
