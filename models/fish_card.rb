# frozen_string_literal: true

class FishCard < Sequel::Model(:fish_cards)
  include FishCards::Modules::Repository
  extend FishCards::Modules::SearchMethods
end
