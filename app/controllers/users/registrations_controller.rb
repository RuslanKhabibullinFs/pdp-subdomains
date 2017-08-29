module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def build_resource(hash = nil)
      super.tap { |user| user.company = current_company }
    end

    def update_resource(resource, params)
      resource.update_attributes(params)
    end

    def account_update_params
      params = devise_parameter_sanitizer.sanitize(:account_update)

      if passwords_blank?(params)
        params.except(:password, :password_confirmation)
      else
        params
      end
    end

    def passwords_blank?(params)
      params[:password].blank? && params[:password_confirmation].blank?
    end
  end
end
