# frozen_string_literal: true

require 'yaml'
require 'sequel'

db_config = YAML.safe_load(File.open('config/database.yml'))[ENV['RACK_ENV'] || 'development']
DB = Sequel.connect(db_config)
