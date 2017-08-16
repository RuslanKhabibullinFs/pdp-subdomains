class UniquenessValidator < ActiveRecord::Validations::UniquenessValidator
  def initialize(klass)
    super
    @klass = options[:model] if options[:model]
  end

  # rubocop:disable Metrics/AbcSize
  def validate_each(record, attribute, value)
    return super unless options[:model]

    record_org = record
    attribute_org = attribute

    attribute = options[:attribute].to_sym
    record = options[:model].new(attribute => value)

    super

    return unless record.errors.any?

    record_org.errors.add(
      attribute_org,
      :taken,
      options.except(:case_sensitive, :scope).merge(value: value)
    )
  end
  # rubocop:enable Metrics/AbcSize
end
