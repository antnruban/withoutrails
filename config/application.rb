# frozen_string_literal: true

# Require all gems listed at Gemfile.
require File.expand_path('../boot', __FILE__)

# Require application files.
# TODO: Find right way to load application according convention.
Dir.glob(File.join('./app', '**', '*.rb'), &method(:require))
