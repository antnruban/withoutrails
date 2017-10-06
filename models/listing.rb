# frozen_string_literal: true

class Listing < ActiveRecord::Base
  belongs_to :rets_data
  belongs_to :user
  has_many :user_listings, dependent: :destroy

  before_save   :populate_realtor_for_search, :determine_visibility, :populate_custom_columns
  after_save    :unfeature_user_listings

  scope :all_agent_listings, lambda { |user|
    where(got_from: user.allowed_feeds.map(&:feed_name))
      .where('listings.realtor_for_search = ? AND listings.removed_at IS NULL', user.brokerage_for_search)
      .order('listings.id DESC')
  }

  scope :agent_brokerage_listings, lambda { |user|
    all_agent_listings(user).where('user_id != ? OR user_id IS NULL', user.id)
  }

  scope :agent_personal_listings, ->(user) { all_agent_listings(user).where('user_id = ?', user.id) }

  scope :agent_featured_listings, lambda { |user|
    all_agent_listings(user).joins(:user_listings).where(user_listings: { featured: true, user_id: user.id })
  }

  scope :agent_previosly_featured_listings, lambda { |user|
    previosly_check_date = Date.current - 15.days
    all_agent_listings(user)
      .joins(:user_listings)
      .where('user_listings.featured = FALSE AND user_listings.updated_at > ?', previosly_check_date)
  }

  scope :agent_removed_listings, lambda { |user|
    where(got_from: user.allowed_feeds.map(&:feed_name))
      .where('listings.realtor_for_search = ? AND listings.removed_at IS NOT NULL', user.brokerage_for_search)
  }

  def self.search(listings_scope, query)
    query_str = "%#{query}%"
    sql_query = 'ad_text ILIKE :query OR mlsid ILIKE :query OR address ILIKE :query ' \
      'OR closest_intersection ILIKE :query OR municipality ILIKE :query OR postal_code ILIKE :query'
    listings_scope.where(sql_query, query: query_str)
  end

  def removed?
    removed_at.present?
  end

  private

  def determine_visibility
    self.visible_to_public = (!removed? && geolocated?)
  end

  def populate_custom_columns
    return if square_feet.blank?

    vals = square_feet.split('-')
    self.square_feet_min = vals.first.gsub(/[^\d]/, '')
    self.square_feet_max = vals.size == 2 ? vals.last.gsub(/[^\d]/, '') : square_feet_min
  end

  def populate_realtor_for_search
    return unless realtor && (realtor_for_search.blank? || realtor_changed?)

    self.realtor_for_search = realtor.downcase.gsub(/[^a-z0-9]+/i, '').gsub('brokerage', '')
  end

  def unfeature_user_listings
    return unless saved_change_to_removed_at? && removed?
    user_listings.update_all(featured: false)
  end
end
