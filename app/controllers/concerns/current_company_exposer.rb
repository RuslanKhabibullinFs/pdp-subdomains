module CurrentCompanyExposer
  extend ActiveSupport::Concern

  delegate :subdomain, to: :request, prefix: true

  included do
    expose(:current_company) { Company.find_by!(subdomain: request_subdomain) }
    before_action :validates_subdomain
  end

  private

  def validates_subdomain
    valid_default_subdomain? || current_company
  end

  def valid_default_subdomain?
    request_subdomain.empty? || SubdomainConstraint::DEFAULT_SUBDOMAINS.include?(request_subdomain)
  end
end


