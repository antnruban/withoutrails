# frozen_string_literal: true

class UserListing < ActiveRecord::Base
  belongs_to :listing
end
