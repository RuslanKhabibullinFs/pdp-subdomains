class UsersFilterQuery
  ALLOWED_PARAMS = %w[filter_by_rating search sort_by].freeze
  ALLOWED_SORT_PARAMS = %w[rating posts].freeze
  DEFAULT_ORDER_DIRECTION = :desc

  attr_reader :relation, :filter_params
  private :relation, :filter_params

  def initialize(relation = User.all, filter_params = {})
    @relation = relation
    @filter_params = filter_params
  end

  def all
    return sort_by_rating(relation, :desc) if sliced_params.empty?

    sliced_params.reduce(relation) do |relation, (key, value)|
      send(key, relation, value)
    end
  end

  private

  def sliced_params
    filter_params.slice(*ALLOWED_PARAMS).to_h
  end

  def filter_by_rating(relation, rating)
    return relation if rating.blank?
    relation.where(rating: rating)
  end

  def search(relation, query)
    return relation if query.blank?
    relation.search(query)
  end

  def sort_by(relation, params)
    return relation unless ALLOWED_SORT_PARAMS.include? params["option"]
    send("sort_by_#{params['option']}", relation, params["order"] || DEFAULT_ORDER_DIRECTION)
  end

  def sort_by_rating(relation, direction)
    relation.order(rating: direction)
  end

  def sort_by_posts(relation, direction)
    relation.order(posts_count: direction, rating: :desc)
  end
end
