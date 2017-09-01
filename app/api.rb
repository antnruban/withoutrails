# frozen_string_literal: true

class API < Grape::API
  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger
  content_type :json, 'application/json'
  format :json

  mount V1::FakeEndpoint
end
