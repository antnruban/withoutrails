# frozen_string_literal: true

class Listing < Sequel::Model(:listings)
  include Listings::Callbacks
  extend Listings::Scopes

  many_to_one :user
  one_to_many :user_listings

  def removed?
    removed_at.present?
  end
end
