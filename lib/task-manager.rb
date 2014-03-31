require 'ostruct'
# Create our module. This is so other files can start using it immediately

module TM

end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/project_list.rb'
require_relative 'task-manager/employee.rb'
require_relative 'task-manager/DB.rb'
require_relative 'use_case.rb'
require_relative 'use-cases/create_project.rb'
require_relative 'use-cases/list_projects.rb'
require_relative 'use-cases/show_remaining_tasks.rb'
require_relative 'use-cases/show_completed_tasks.rb'
require_relative 'use-cases/add_task_to_project.rb'
require_relative 'use-cases/show_employees_in_project.rb'
require_relative 'use-cases/create_employee.rb'
require_relative 'use-cases/recruit_employee.rb'
require_relative 'use-cases/create_task.rb'
require_relative 'use-cases/mark_task_complete.rb'

require 'pry-debugger'
# Dir[File.dirname(__FILE__) + '../lib/task-manager/*.rb'].each {|file| require file }
# Dir[File.dirname(__FILE__) + '../lib/use-cases/*.rb'].each {|file| require file }
