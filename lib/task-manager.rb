
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
# Added database
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/DB.rb'
