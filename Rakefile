# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'quality/rake/task'

Rails.application.load_tasks
Quality::Rake::Task.new do |t|
  t.verbose = true
end
