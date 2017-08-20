module SubdomainsHelper
  def visit_company(company, path = "/")
    using_app_host("http://#{company.subdomain}.lvh.me") do
      visit path
    end
  end

  def using_app_host(host)
    original_host = Capybara.app_host
    Capybara.app_host = host
    yield
  ensure
    Capybara.app_host = original_host
  end
end

RSpec.configure do |config|
  config.include SubdomainsHelper, type: :feature
end
