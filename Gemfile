source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.1"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "pg_search"

# Admin
gem "administrate", "~> 0.8.1"

# Views
gem "bootstrap-sass"
gem "bootstrap-material-design"
gem "simple_form"
gem "slim"
gem "skim"
gem "font-awesome-sass"

# Other Gems
gem "devise"
gem "draper"
gem "decent_decoration"
gem "decent_exposure"
gem "pundit"
gem "kaminari"
gem "interactor"
gem "responders"
gem "factory_girl_rails"
gem "faker"
gem "seedbank"

group :test do
  gem "capybara"
  gem "capybara-webkit"
  gem "capybara-screenshot"
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner"
  gem "email_spec"
  gem "formulaic"
  gem "simplecov"
  gem "shoulda-matchers"
end

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "bullet"
  gem "coffeelint"
  gem "dotenv-rails"
  gem "rspec-rails"
  gem "rspec-its"
  gem "jasmine", "> 2.0"
  gem "jasmine-jquery-rails"
  gem "pry-rails"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
  gem "scss_lint", require: false
  gem "slim_lint", require: false
  gem "selenium-webdriver"
end

group :development do
  gem "foreman", require: false
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-commands-rspec"
  gem "slim-rails"
  gem "spring-watcher-listen", "~> 2.0.0"
end
