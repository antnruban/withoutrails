# frozen_string_literal: true

module Listings
  module Scopes
    #
    # Listing class methods.
    #

    def active
      filter(status: 'A').all
    end

    def all_agent_listings(user)
      all_agent_listings_dataset(user).order(Sequel.desc(:id)).all
    end

    def agent_brokerage_listings(user)
      query = Sequel.lit('user_id != ? OR user_id IS NULL', user.id)
      all_agent_listings_dataset(user).where(query).all
    end

    def agent_personal_listings(user)
      all_agent_listings_dataset(user).where(user_id: user.id).all
    end

    def agent_featured_listings(user)
      all_agent_listings_dataset(user).join(:user_listings, listing_id: :id, featured: true, user_id: user.id).all
    end

    def agent_previosly_featured_listings(user)
      previosly_check_date = Date.current - 15.days
      statement = Sequel.lit('user_listings.featured = FALSE AND user_listings.updated_at > ?', previosly_check_date)
      all_agent_listings_dataset(user).join(:user_listings, statement).all
    end

    def agent_removed_listings(user)
      user_allowed_feeds_dataset(user)
        .where(realtor_for_search: user.brokerage_for_search)
        .exclude(removed_at: nil).all
    end

    def search(listings_scope, query)
      listing_ids = listings_scope.map(&:id)
      statement = Sequel.join(%i[ad_text mlsid address closest_intersection municipality postal_code])
      where(id: listing_ids).where(statement.ilike("%#{query}%")).all
    end

    private

    def all_agent_listings_dataset(user)
      user_allowed_feeds_dataset(user).where(realtor_for_search: user.brokerage_for_search, removed_at: nil)
    end

    def user_allowed_feeds_dataset(user)
      where(got_from: user.allowed_feeds.map(&:feed_name))
    end
  end
end
