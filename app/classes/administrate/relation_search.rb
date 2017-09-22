module Administrate
  class RelationSearch < ::Administrate::Search
    attr_reader :relation
    private :relation

    def initialize(scoped_resource:, dashboard_class:, term:, relation: nil)
      super(scoped_resource, dashboard_class, term)
      @relation = relation
    end

    def run
      if @term.blank?
        (relation || @scoped_resource).all
      else
        (relation || @scoped_resource).where(query, *search_terms)
      end
    end
  end
end
