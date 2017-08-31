# frozen_string_literal: true

class API < Grape::API
  get :hello do
    { hello: 'world' }
  end

  get :'/' do
    { hello: 'hello root' }
  end
end
