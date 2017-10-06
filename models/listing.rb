# frozen_string_literal: true

class Listing < Sequel::Model(:listings)
  many_to_one :user

  before_save   :populate_realtor_for_search, :determine_visibility
  after_save    :unfeature_user_listings

  class << self
    def active
      filter(status: 'A').all
    end

    def all_agent_listings(user)
      all_agent_listings_dataset(user).all
    end

    def search(listings_scope, query)
      sql_query = 'ad_text ILIKE :query OR mlsid ILIKE :query OR address ILIKE :query ' \
        'OR closest_intersection ILIKE :query OR municipality ILIKE :query OR postal_code ILIKE :query'
      listings_scope.where(Sequel.lit(sql_query, query: "%#{query}%")).all
    end

    private

    def all_agent_listings_dataset(user)
      where(got_from: user.allowed_feeds.map(&:feed_name))
        .where(Sequel.lit('listings.realtor_for_search = ? AND listings.removed_at IS NULL', user.brokerage_for_search))
        .order(Sequel.lit('listings.id DESC'))
    end
  end

  def removed?
    removed_at.present?
  end
end
