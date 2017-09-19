class SubdomainConstraint
  DEFAULT_SUBDOMAINS = %w[www ftp mail].freeze

  def self.matches?(request)
    request.subdomain.present? && !DEFAULT_SUBDOMAINS.include?(request.subdomain)
  end
end
