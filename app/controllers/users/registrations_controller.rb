module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def build_resource(hash = nil)
      super.tap { |user| user.company = current_company }
    end

    def update_resource(resource, params)
      if params[:password].blank? & params[:password_confirmation].blank?
        resource.update_without_password(params)
      else
        resource.update_with_password(params)
      end
    end
  end
end
