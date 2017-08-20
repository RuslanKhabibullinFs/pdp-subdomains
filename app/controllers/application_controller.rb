require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  protect_from_forgery with: :exception

  respond_to :html
  responders :flash

  include Authentication
  include Authorization
  include SubdomainHelper
  include BulletHelper
end
