source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.1"

gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-sass", "~> 3.4.1"
gem "coffee-rails", "~> 4.2"
gem "devise", ">= 4.6.0"
gem "faker", "~> 1.9"
gem "figaro"
gem "font-awesome-rails", "~> 4.7"
gem "gemoji"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "omniauth-google-oauth2"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.2"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "mysql2", "~> 0.5.2"
  gem "pry"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
