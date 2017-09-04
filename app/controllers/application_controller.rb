require "application_responder"

class ApplicationController < ActionController::Base
  include Authentication
  include SubdomainHelper
  include BulletHelper

  self.responder = ApplicationResponder

  protect_from_forgery with: :exception

  respond_to :html
  responders :flash
end
