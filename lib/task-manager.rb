
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative "task-manager/project_list.rb"
require_relative "task-manager/employee.rb"
require_relative "task-manager/db.rb"
require_relative "use_case.rb"
require_relative "task-manager/use_case/project_show.rb"
require_relative "task-manager/use_case/assign_task.rb"
require 'pry-debugger'
