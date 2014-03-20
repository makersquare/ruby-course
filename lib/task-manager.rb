# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/client.rb'
require_relative 'task-manager/db.rb'
require_relative 'task-manager/employee.rb'
require_relative 'task-manager/middleman.rb'

x = TM::Client.new
x.main_menu
