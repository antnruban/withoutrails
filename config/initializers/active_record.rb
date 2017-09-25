# frozen_string_literal: true

require 'logger'
require 'active_record'
require_relative '../db_config'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(DB_CONFIG)
