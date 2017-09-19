require "application_responder"

class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include BulletHelper

  respond_to :html
  responders :flash

  self.responder = ApplicationResponder
  delegate :subdomain, to: :request, prefix: true

  expose(:current_company) { Company.find_by!(subdomain: request_subdomain) }

  before_action :validates_subdomain
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  private

  def validates_subdomain
    valid_default_subdomain? || current_company
  end

  def valid_default_subdomain?
    request_subdomain.empty? || SubdomainConstraint::DEFAULT_SUBDOMAINS.include?(request_subdomain)
  end
end
