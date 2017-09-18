# frozen_string_literal: true

module V1
  class FakeEndpoint < V1::Base
    namespace :fish_cards do
      get do
        FishCard.all
      end

      get ':id', requirements: { id: /[0-9]+/ } do
        FishCard.find!(params[:id])
      end

      params do
        requires 'message',     type: String
        optional 'description', type: String
      end

      post :create do
        FishCard.create(message: 'message', description: 'description')
      end
    end
  end
end
