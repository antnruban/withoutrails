# frozen_string_literal: true

class AllowedFeed < Sequel::Model
  one_to_many :users
end
