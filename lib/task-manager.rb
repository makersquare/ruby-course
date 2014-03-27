
# Create our module. This is so other files can start using it immediately
module TM
end



# Require all of our project files
require_relative 'use_case.rb'
require_relative 'task-manager/database.rb'
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/project-list.rb'

# Google "ruby require directory"
require_relative 'task-manager/use_cases/add_task_to_project'
require 'pry-debugger'

