# frozen_string_literal: true

class Listing < Sequel::Model(:listings)
  many_to_one :user
  one_to_many :user_listings

  ##
  # Callbacks
  ##

  def before_save
    populate_realtor_for_search
    determine_visibility
    populate_custom_columns
    super
  end

  def after_save
    unfeature_user_listings
    super
  end

  ##
  # Scopes
  ##

  class << self
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

  ##
  # Model methods.
  ##

  def removed?
    removed_at.present?
  end

  private

  def determine_visibility
    self.visible_to_public = !removed? && geolocated
  end

  def populate_custom_columns
    return if square_feet.blank?

    vals = square_feet.split('-')
    self.square_feet_min = vals.first.gsub(/[^\d]/, '')
    self.square_feet_max = vals.size == 2 ? vals.last.gsub(/[^\d]/, '') : square_feet_min
  end

  def populate_realtor_for_search
    return unless realtor && (realtor_for_search.blank? || column_changed?(:realtor))

    self.realtor_for_search = realtor.downcase.gsub(/[^a-z0-9]+/i, '').gsub('brokerage', '')
  end

  def unfeature_user_listings
    UserListing.where(listing_id: id, featured: true).update(featured: false) if removed?
  end
end

# Dirty plugin supports `dirty` methods, like :initial_value(:column_name), :column_change(:column_name),
# :column_changed?(:column_name), :reset_column, etc.

Listing.plugin(:dirty)
