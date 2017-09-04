class PostDecorator < ApplicationDecorator
  decorates_association :user

  delegate :title, :content
  delegate :full_name, to: :user, prefix: true

  def content_preview
    h.truncate(object.content, length: 400, separator: " ")
  end

  def formatted_creation_date
    object.created_at.strftime("%d-%m-%Y")
  end
end
