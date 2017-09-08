# frozen_string_literal: true

module V1
  class FakeEndpoint < Grape::API
    get :hello do
      FishCard.create!
      { hello: 'world' }
    end

    get :'/' do
      { hello: 'hello root' }
    end
  end
end
