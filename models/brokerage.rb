# # frozen_string_literal: true

class Brokerage < ActiveRecord::Base
  has_many :users
end
