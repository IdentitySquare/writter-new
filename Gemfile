source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

gem 'kaminari'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Soft Delete Records
gem 'discard', '~> 1.2'

gem 'simple_form'
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
  
# Postgres
gem 'pg'


# Omniauth

gem 'omniauth'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-google-oauth2', "~> 1.0"

# Sidekiq
gem 'sidekiq'

gem 'rack-canonical-host'

gem 'postmark-rails'

# Better Logs
gem "lograge"

gem 'lograge-sql'

gem "logstop"

# Security
gem 'rack-attack'

# Log in
gem 'devise'


# Checking email format
gem "valid_email2"

gem 'strong_password', '~> 0.0.9'

# Hashid 
gem "hashid-rails", "~> 1.0"


# SEO
gem "meta-tags"

# Safer Migrations
gem "strong_migrations"

gem 'awesome_print'

gem 'annotate'

gem 'high_voltage', '~> 3.1'

gem 'haml-rails'
gem 'html2haml'
# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'bullet'

  # Clearer error messages
  gem "better_errors"
  gem "binding_of_caller"

  gem "letter_opener"
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"

  
  # Automated testing
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers','~> 5.0'

  gem 'factory_bot_rails'
  gem 'faker'
  gem 'bullet'
end

gem "factory_bot", "~> 6.2"

gem "pundit", "~> 2.3"

gem "timecop", "~> 0.9.6"
