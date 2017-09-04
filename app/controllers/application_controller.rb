require "application_responder"

class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include SubdomainHelper
  include BulletHelper

  respond_to :html
  responders :flash

  self.responder = ApplicationResponder

  protect_from_forgery with: :exception
end
