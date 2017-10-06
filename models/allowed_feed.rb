# frozen_string_literal: true

class AllowedFeed < Sequel::Model(:allowed_feeds)
  many_to_one :user
end
