class UsersFilterQuery < BaseFilterQuery
  ALLOWED_PARAMS = %w[filter_by_rating sort_by].freeze
  ALLOWED_SORT_PARAMS = %w[rating posts].freeze
  DEFAULT_ORDER_DIRECTION = :desc

  private

  def filter_by_rating(relation, rating)
    return relation if rating.blank?
    relation.where(rating: rating)
  end

  def sort_by(relation, params)
    return relation unless ALLOWED_SORT_PARAMS.include? params[:option]
    send("sort_by_#{params[:option]}", relation, params[:order] || DEFAULT_ORDER_DIRECTION)
  end

  def sort_by_rating(relation, order)
    relation.order(rating: order)
  end

  def sort_by_posts(relation, order)
    relation.order(posts_count: order, rating: :desc)
  end
end
