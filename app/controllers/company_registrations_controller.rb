class CompanyRegistrationsController < ApplicationController
  expose(:company_registration_form)

  delegate :owner, to: :company_registration_form
  delegate :company, to: :owner, prefix: true

  def new
  end

  def create
    if company_registration_form.save
      redirect_to(new_user_session_url(subdomain: owner_company.subdomain), notice: t(".success"))
    else
      respond_with company_registration_form
    end
  end

  private

  def company_registration_form_params
    params.require(:company_registration_form).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :company_name,
      :company_subdomain
    )
  end
end
