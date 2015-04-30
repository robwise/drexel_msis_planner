source "https://rubygems.org"
ruby "2.2.0"
gem "rails", "~>4.2.0"
gem "sass-rails", "~> 4.0.3"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc
gem "bootstrap-sass"
gem "devise"
gem "haml-rails"
gem "pg"
gem "pundit"
gem "simple_form"
gem "titleize"
gem "autoprefixer-rails"
gem "compass-rails"
gem "annotate", "~> 2.6.6"
gem "httparty"
group :production do
  gem "unicorn"
  gem "rails_12factor"
end
group :development do
  gem "spring"
  gem "better_errors"
  gem "binding_of_caller"
  gem "guard-bundler"
  gem "guard-rails"
  gem "guard-rspec"
  gem "html2haml"
  gem "quiet_assets"
  gem "rails_layout"
  gem "rb-fchange", require: false
  gem "rb-fsevent", require: false
  gem "rb-inotify", require: false
  gem "rack-livereload"
  gem "guard-livereload", require: false
  gem "rubocop"
  gem "rubocop-rspec"
end
group :development, :test do
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "spring-commands-rspec"
  gem "byebug"
end
group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "faker"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers", require: false
  gem "capybara-webkit"
  gem "growl"
  gem "rake" # required for Travis-CI
  gem "codeclimate-test-reporter", require: nil
end
