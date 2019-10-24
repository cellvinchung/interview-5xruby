RSpec.shared_context 'Login' do
  background do
    authenticate
  end

  def authenticate
    visit login_path
    within('form') do
      fill_in User.human_attribute_name(:email), :with => 'demo@example.com'
      fill_in User.human_attribute_name(:password), :with => '123456'
    end
    click_button I18n.t("login")
  end
end