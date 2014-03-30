
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/db.rb'
require_relative 'task-manager/employee.rb'
require_relative 'use_case.rb'
Dir[File.dirname(__FILE__) + '/use_case/*.rb'].each {|file| require_relative file }
#require_relative 'use_case/create_project.rb'

