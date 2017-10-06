# frozen_string_literal: true

class UserListing < Sequel::Model(:user_listings)
  many_to_one :listing
end
