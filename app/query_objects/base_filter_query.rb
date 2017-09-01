class BaseFilterQuery
  ALLOWED_PARAMS = [].freeze

  attr_reader :relation, :filter_params
  private :relation, :filter_params

  def initialize(relation, filter_params)
    @relation = relation
    @filter_params = filter_params
  end

  def all
    sliced_params.reduce(relation) { |relation, (key, value)| send(key.to_s, relation, value) }
  end

  private

  def sliced_params
    filter_params.slice(*self.class::ALLOWED_PARAMS).to_h
  end
end
