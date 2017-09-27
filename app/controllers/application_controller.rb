require "application_responder"

class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include BulletHelper
  include CurrentCompanyExposer

  respond_to :html
  responders :flash

  self.responder = ApplicationResponder

  before_action :authenticate_user!

  protect_from_forgery with: :exception
end
