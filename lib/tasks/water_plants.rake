require 'rake'
namespace :watering_run do
  desc 'Waters plants if needed'
  task :water => :environment do
    User.water_everyday
  end
end
