# frozen_string_literal: true

# Require all gems listed at Gemfile.
require File.expand_path('../boot', __FILE__)
require 'active_support/dependencies'

paths_to_load = %w[./app ./models]
ActiveSupport::Dependencies.autoload_paths = paths_to_load
