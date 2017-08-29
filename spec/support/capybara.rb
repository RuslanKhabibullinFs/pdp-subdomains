Capybara.configure do |config|
  config.javascript_driver = :webkit
  config.match = :prefer_exact
  config.always_include_port = true
  config.default_max_wait_time = 10
end
