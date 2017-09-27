require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    company: Field::BelongsTo,
    user: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    content: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    average_rating: Field::Number.with_options(decimals: 2)
  }.freeze

  COLLECTION_ATTRIBUTES = %i[company title user id average_rating].freeze

  SHOW_PAGE_ATTRIBUTES = %i[company user id title content created_at updated_at average_rating].freeze

  FORM_ATTRIBUTES = %i[title content].freeze

  def display_resource(post)
    "##{post.id} #{post.title}"
  end
end
