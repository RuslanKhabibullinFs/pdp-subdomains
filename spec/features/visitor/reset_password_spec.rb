require "rails_helper"

feature "Reset password" do
  let!(:company) { create(:company) }
  let(:user) { create(:user, company: company) }
  let(:new_password) { "newHardPassword2" }

  def update_user
    fill_in "New password", with: new_password
    fill_in "Confirm your new password", with: new_password
    click_button "Change my password"
  end

  def fill_and_submit_reset_form(email)
    fill_in "Email", with: email
    click_button "Send me reset password instructions"
  end

  background { visit_company(company, new_user_password_path) }

  scenario "Visitor fill reset form with invalid email" do
    fill_and_submit_reset_form("wrongEmail@email.com")

    expect(page).to have_content "problems"
  end

  scenario "Visitor resets his password" do
    fill_and_submit_reset_form(user.email)

    open_email user.email

    using_app_host("http://#{company.subdomain}.lvh.me") do
      visit_in_email("Change my password")
    end

    update_user

    expect(page).to have_content "Your password has been changed successfully"
  end
end
