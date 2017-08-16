require "application_responder"

class ApplicationController < ActionController::Base
  include Authentication
  include SubdomainHelper
  include BulletHelper

  self.responder = ApplicationResponder

  protect_from_forgery with: :exception

  respond_to :html
  responders :flash

  def after_sign_in_path_for(_record)
    posts_path
  end
end
