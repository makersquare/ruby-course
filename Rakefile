task :console do
  require './lib/project_manager.rb'
  PM::Repos.adapter = 'mtm_exercise'

  PM.projects = PM::Repos::Projects.new
  PM.employees = PM::Repos::Employees.new
  PM.memberships = PM::Repos::Memberships.new

  require 'irb'
  ARGV.clear
  IRB.start
end
