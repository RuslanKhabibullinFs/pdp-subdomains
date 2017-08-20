Capybara.configure do |config|
  config.javascript_driver = :webkit
  config.match = :prefer_exact
  config.always_include_port = true
end
