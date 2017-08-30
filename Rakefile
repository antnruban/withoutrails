task default: ['withoutruby:start']

namespace :withoutruby do
  desc 'Run server.'
  task :start do
    sh 'rackup config.ru -p 3000 --host 0.0.0.0'
  end
end
