# frozen_string_literal: true

class User < Sequel::Model(:users)
  one_to_many :allowed_feeds
  one_to_many :user_listings
  one_to_many :listings
  many_to_one :brokerage

  def brokerage_for_search
    return '' unless brokerage
    brokerage.name.downcase.gsub(/[^a-z0-9]+/i, '').gsub('brokerage', '')
  end
end
