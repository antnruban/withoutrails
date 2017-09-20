# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'test'
require File.expand_path('../../config/application', __FILE__)
require 'rack/test'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
