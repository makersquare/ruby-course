
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/project_list.rb'
# create a client.rb file in the lib; client.rb is what actually
# asks the user for information. project_list.rb contains
# the class that interacts with the business logic
