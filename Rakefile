# frozen_string_literal: true

task default: ['withoutrails:start']

namespace :withoutrails do
  desc 'Run server.'
  task :start do
    sh 'rackup config.ru -p 3000 --host 0.0.0.0'
  end
end
