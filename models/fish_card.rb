# frozen_string_literal: true

class FishCard < Sequel::Model
  include FishCards::Modules::Repository
  extend FishCards::Modules::SearchMethods
end
