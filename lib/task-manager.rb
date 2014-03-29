
module TM
end

# Require all of our project files
require_relative 'task-manager/db.rb'
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/pm.rb'
require_relative 'task-manager/db.rb'
require_relative 'task-manager/employee.rb'
require_relative 'usecase.rb'
require_relative 'usecases/create_project.rb'
require_relative 'usecases/get_project_tasks.rb'
require_relative 'usecases/create_task.rb'
require_relative 'usecases/mark_task_complete.rb'
require_relative 'usecases/complete_task_list.rb'
require_relative 'usecases/incomplete_task_list.rb'
require_relative 'usecases/create_employee.rb'
require_relative 'usecases/add_employee_to_project.rb'
require_relative 'usecases/assign_task_to_employee.rb'
require_relative 'usecases/get_all_projects.rb'
require_relative 'usecases/get_employees_on_project.rb'
require_relative 'usecases/get_all_employees.rb'
require_relative 'usecases/get_projects_for_employee.rb'
require_relative 'usecases/get_tasks_for_employee.rb'
require 'ostruct'
