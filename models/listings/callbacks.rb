# frozen_string_literal: true

module Listings
  module Callbacks
    #
    # Listing callbacks.
    #

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
end

Listing.plugin(:dirty)
