source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.3'

gem 'rails', '~> 5.2.1'

gem 'pg', '>= 0.18', '< 2.0'

gem 'puma', '~> 3.11'

gem 'slim-rails'

gem 'webpacker'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'dry-validation'
gem 'reform', '~> 2.3.0.rc1'
gem 'reform-rails', '~> 0.2.0.rc2'

gem 'trailblazer', '~> 2.1.0.rc1'
gem 'trailblazer-cells'
gem 'trailblazer-rails'

gem 'cells-rails'
gem 'cells-slim'

gem 'multi_json'
gem 'roar'

gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug'

  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'action-cable-testing'

  gem 'coveralls', require: false

  gem 'database_cleaner'

  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'

  gem 'chromedriver-helper'
end
