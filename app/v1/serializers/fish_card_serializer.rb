# frozen_string_literal: true

module V1
  module Serializers
    class FishCardSerializer < V1::Serializers::Base
      attributes :message, :description
    end
  end
end
