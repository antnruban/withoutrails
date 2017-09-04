# frozen_string_literal: true

class API < Grape::API
  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger
  content_type :json, 'application/json'
  format :json

  mount V1::FakeEndpoint

  # If requested route was not found, return the client error.
  route :any, '*path' do
    error!({ message: 'Route not found' }, 404)
  end
end
