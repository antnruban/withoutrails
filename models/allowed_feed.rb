# # frozen_string_literal: true

class AllowedFeed < ActiveRecord::Base
  belongs_to :user
end
