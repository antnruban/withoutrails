# frozen_string_literal: true

class API < Grape::API
  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger
  content_type :json, 'application/json'
  format       :json

  rescue_from :all do |e|
    body = JSONAPI::Serializer.serialize_errors(e.message)
    error!(body, 404) if e.class == RecordNotFound
  end

  mount V1::Base

  # If requested route was not found, return the client error.
  route :any, '*path' do
    error_status = 404
    message = "Route '#{request.path}' wasn't found"
    error!({ errors: [{ status: error_status, title: 'Ruting Error', details: message }] }, error_status)
  end
end
