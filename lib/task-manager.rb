
# Create our module. This is so other files can start using it immediately
module TM
  require 'time'
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
