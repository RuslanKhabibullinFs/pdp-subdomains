require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    posts: Field::HasMany,
    company: Field::BelongsTo,
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    rating: Field::Number.with_options(decimals: 2),
    posts_count: Field::Number
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    first_name
    last_name
    email
    posts
    rating
    id
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    posts
    company
    id
    email
    first_name
    last_name
    created_at
    rating
    posts_count
  ].freeze

  def display_resource(user)
    "#{user.first_name} #{user.last_name} - #{user.email}"
  end
end
