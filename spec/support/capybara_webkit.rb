Capybara::Webkit.configure do |config|
  config.block_unknown_urls
  config.allow_url("*.lvh.me")
end
