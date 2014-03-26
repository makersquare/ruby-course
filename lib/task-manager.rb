
# Create our module. This is so other files can start using it immediately
module TM
end


# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/database.rb'
require_relative 'task-manager/employee.rb'
require_relative 'use_case.rb'

# this looks nicer but doesn't work
# Dir["task-manager/use_cases/*"].each {|file| require file }

# adds all files in task-manager/use_cases
Dir["#{File.dirname(__FILE__)}/task-manager/use_cases/*.rb"].each { |f| require(f) }

require 'pry-debugger'

