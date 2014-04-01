
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/project_list.rb'
require_relative 'task-manager/employee.rb'
require_relative 'task-manager/database.rb'
require_relative 'use_case.rb'
Dir[File.dirname(__FILE__) + '/use_cases/*.rb'].each {|file| require file }
