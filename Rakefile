# frozen_string_literal: true

require 'sequel'
require_relative './config/db_config'

desc 'Run pry session with required application'
task :console do
  sh 'pry -r ./config/application'
end

namespace :db do
  desc 'Create the database'
  task :create do
    Sequel.connect(DB_ADMIN_CONFIG) do |db|
      db.execute "CREATE DATABASE #{DB_CONFIG['database']}"
      puts 'Database created.'
    end
  end

  desc 'Migrate the database'
  task :migrate do
    Sequel.extension :migration
    DB = Sequel.connect(DB_CONFIG)
    Sequel::Migrator.run(DB, './db/migrate/', use_transactions: true)
    puts 'Database migrated.'
  end

  desc 'Drop the database'
  task :drop do
    Sequel.connect(DB_ADMIN_CONFIG) do |db|
      db.execute "DROP DATABASE IF EXISTS #{DB_CONFIG['database']}"
      puts 'Database deleted.'
    end
  end

  desc 'Reset the database'
  task reset: %i[drop create migrate]
end

namespace :g do
  desc 'Generate migration'
  task :migration do
    name = ARGV[1] || raise('Specify name: rake g:migration your_migration')
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)

    File.open(path, 'w') do |file|
      file.write <<~RUBY
        # frozen_string_literal: true

        Sequel.migration do
          change do
            # create_table :table_name do
              # primary_key :id
              # String :field_name, null: false
            # end
          end
        end
      RUBY
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
