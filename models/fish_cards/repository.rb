# frozen_string_literal: true

module FishCards
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
