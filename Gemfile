# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'aasm'
gem 'active_storage_validations'
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.3.3'
gem 'brakeman'
gem 'bundle-audit'
gem 'cssbundling-rails'
gem 'image_processing'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'
gem 'pagy', '~> 8.6'
gem 'puma', '>= 6.4.3'
gem 'pundit'
gem 'rails', '~> 7.1', '>= 7.1.3.4'
gem 'rails-i18n'
gem 'ransack'
gem 'rexml', '~> 3.3', '>= 3.3.3'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'simple_form'
gem 'slim-rails'
gem 'sprockets-rails'
gem 'stackprof'
gem 'stimulus-rails'
gem 'turbo-rails', '~> 1.0.0'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'webrick', '~> 1.8', '>= 1.8.2'

group :production do
  gem 'pg', '~> 1.4'
end

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails'
  gem 'faker'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'html2slim'
  gem 'i18n-debug'
  gem 'rubocop'
  gem 'rubocop-capybara'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'slim_lint'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'minitest-power_assert'
  gem 'selenium-webdriver'
end
