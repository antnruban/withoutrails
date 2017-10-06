# # frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :allowed_feeds
  has_many :user_listings
  has_many :listings
  belongs_to :brokerage

  def brokerage_for_search
    return '' unless brokerage
    brokerage.name.downcase.gsub(/[^a-z0-9]+/i, '').gsub('brokerage', '')
  end
end
