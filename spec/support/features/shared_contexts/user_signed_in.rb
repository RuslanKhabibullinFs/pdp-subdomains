shared_context "current user signed in" do
  let!(:current_company) { create(:company) }
  let(:current_user) { create(:user, company: current_company) }

  background do
    visit_company(current_company)
    fill_in "Email", with: current_user.email
    fill_in "Password", with: current_user.password
    click_button "Log in"
  end
end
