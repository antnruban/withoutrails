# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.1'

# Application dependencies.
gem 'grape', '~> 1.0.0'
gem 'grape-middleware-logger', '~> 1.9.0'
gem 'jsonapi-serializers', '~> 1.0.0'
gem 'rack', '~> 2.0.3'
gem 'rack-protection', '2.0.0'
gem 'sequel', '~> 5.0.0'
gem 'pg', '~> 0.21.0'

group :test, :development do
  gem 'pry', '~> 0.10.4'
  gem 'thin', '~> 1.7.2'
end

group :test do
  gem 'rspec', '~> 3.6.0'
  gem 'faker', '~> 1.8.4'
  gem 'rack-test', '~> 0.7.0'
  gem 'factory_girl', '~> 4.8.0'
  gem 'database_cleaner', '~> 1.6.1'
end
