source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3", ">= 7.0.3.1"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'rspec-rails', '~>6.0.0.rc1'
  gem 'shoulda-matchers', '~>5.1.0'
  gem 'webmock', '~>3.14.0'
end

gem 'grape', '~>1.6.2'
gem 'grape-swagger', '~>1.4.2'
gem 'rswag-ui', '~>2.5.1'
gem 'devise', '~>4.8.1'
gem 'faker', '~>2.21.0'
gem 'factory_bot', '~>6.2.1'
gem 'grape-active_model_serializers', '~>1.5.2'
gem 'figaro', '~>1.2.0'
gem 'faraday', '~>2.3.0'
gem 'delayed_job', '~>4.1.10'
gem 'delayed_job_active_record', '~>4.1.7'
gem 'daemons', '~>1.4.1'
gem 'rails_event_store', '~>2.5.1'