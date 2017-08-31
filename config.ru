# frozen_string_literal: true

require_relative 'config/application'

generate_secure_hex = proc { SecureRandom.hex(32) }

cookies_parameters = {
  key: 'rack.session',
  domain: 'foo.com',
  secret: generate_secure_hex.call,
  old_secret: generate_secure_hex.call
}

use Rack::CommonLogger
use Rack::Session::Cookie, cookies_parameters
run Rack::Cascade.new [API]
