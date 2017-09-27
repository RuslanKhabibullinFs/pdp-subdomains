require "administrate/base_dashboard"

class CompanyDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    owner: Field::BelongsTo.with_options(class_name: "User"),
    users: Field::HasMany,
    posts: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    subdomain: Field::String,
    owner_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[owner users posts id].freeze
  SHOW_PAGE_ATTRIBUTES = %i[owner id name subdomain created_at updated_at].freeze
  FORM_ATTRIBUTES = %i[name].freeze

  def display_resource(company)
    company.name
  end
end
