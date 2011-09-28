require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :test => :spec

task :run do
  puts "Starting the game."
  exec "bin/siwoti"
end

task :default => :run

