require "application_responder"

class ApplicationController < ActionController::Base
  include BulletHelper

  self.responder = ApplicationResponder

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html
end
