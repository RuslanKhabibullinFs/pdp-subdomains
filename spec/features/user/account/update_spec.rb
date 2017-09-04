require "rails_helper"

feature "Update account" do
  include_context "current user signed in"

  def fill_and_submit_edit_form(attributes)
    fill_form(:user, :edit, attributes)
    click_button "Update"
  end

  background { visit_company(current_company, edit_user_registration_path(current_user)) }

  scenario "User update profile with invalid data" do
    fill_and_submit_edit_form(password: "newPass2", password_confirmation: "error")

    expect(page).to have_content "problems"
  end

  scenario "User update profile with valid data" do
    fill_and_submit_edit_form(first_name: "John")

    expect(page).to have_content "updated successfully"
  end
end
