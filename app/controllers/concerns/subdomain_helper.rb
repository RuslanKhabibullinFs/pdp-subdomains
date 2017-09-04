module SubdomainHelper
  extend ActiveSupport::Concern

  delegate :subdomain, to: :request, prefix: true

  included do
    expose(:current_company) { Company.find_by!(subdomain: request_subdomain) }

    before_action :validates_subdomain
  end

  private

  def validates_subdomain
    return if valid_default_subdomain?
    render404 unless current_company
  end

  def render404
    raise ActiveRecord::RecordNotFound
  end

  def valid_default_subdomain?
    request_subdomain.empty? || Subdomains::Base::DEFAULT_SUBDOMAINS.include?(request_subdomain)
  end
end
