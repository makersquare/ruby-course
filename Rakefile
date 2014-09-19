task :console do
  require './lib/project_manager.rb'
  require 'irb'
  PM::Repos.adapter = 'mtm_exercise'
  PM.projects = PM::Repos::Projects.new
  PM.employees = PM::Repos::Employees.new
  ARGV.clear
  IRB.start
end
