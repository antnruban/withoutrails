# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

# Set up gems listed in the Gemfile and require they.
require 'bundler/setup'

Bundler.require
