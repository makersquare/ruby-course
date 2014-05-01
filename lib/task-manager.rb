
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/terminal-client.rb'

t = TM::TerminalClient.new
t.run_program
