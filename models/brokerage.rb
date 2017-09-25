# frozen_string_literal: true

class Brokerage < Sequel::Model(:brokerages)
  many_to_one :users
end
