module Admin
  class PostsController < Admin::ApplicationController
    expose :relation, -> { Post.where(company: current_company) }

    private

    def find_resource(id)
      relation.find_by!(id: id)
    end
  end
end
