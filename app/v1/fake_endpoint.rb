# frozen_string_literal: true

module V1
  class FakeEndpoint < Grape::API
    namespace :fish_cards do
      get do
        FishCard.all
      end

      get :create do
        FishCard.create(message: 'message', description: 'description')
      end
    end
  end
end
