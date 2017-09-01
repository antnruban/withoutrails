#\-p 3000 --host 0.0.0.0 -q
# frozen_string_literal: true

require_relative 'config/application'

generate_secure_hex = proc { SecureRandom.hex(32) }

cookies_parameters = {
  key: 'rack.session',
  domain: 'foo.com',
  secret: generate_secure_hex.call,
  old_secret: generate_secure_hex.call
}

use Rack::Reloader, 0
use Rack::Session::Cookie, cookies_parameters
run API
