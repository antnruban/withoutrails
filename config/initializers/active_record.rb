# frozen_string_literal: true

require 'yaml'
require 'logger'
require 'active_record'

db_config = YAML.safe_load(File.open('config/database.yml'))[ENV['RACK_ENV'] || 'development']
db_config_admin = db_config.merge('database' => 'postgres', 'schema_search_path' => 'public')

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(db_config_admin)
