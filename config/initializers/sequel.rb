# frozen_string_literal: true

require 'sequel'
require_relative '../db_config'

DB = Sequel.connect(DB_CONFIG)
DB.logger = Logger.new(STDOUT)

# Below class contains common configurations, hooks or methods for all Sequel's model.

module Sequel
  class Model
    def before_create
      self.created_at ||= Time.now
      super
    end

    def before_update
      self.updated_at = Time.now
      super
    end
  end
end
