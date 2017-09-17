# frozen_string_literal: true

module FishCards
  module Modules
    module Repository
      def say
        puts '-----'
        puts message
        puts '-----'
        puts description
        puts '-----'
      end
    end
  end
end

class RecordNotFound < RuntimeError
end
