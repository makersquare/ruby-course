require 'ostruct'
# Create our module. This is so other files can start using it immediately
module TM
  def self.db
      @db ||= TM::DB.new
  end
end


# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/project_list.rb'
require_relative 'task-manager/employee.rb'
require_relative 'task-manager/DB.rb'
require_relative 'usecase/Usecase.rb'
require_relative 'usecase/create_project.rb'
require_relative 'usecase/show_remaining_tasks.rb'
require_relative 'usecase/show_completed_tasks.rb'
require_relative 'usecase/get_project_employees.rb'
require_relative 'usecase/assign_employee_to_project.rb'
require_relative 'usecase/add_task_to_project.rb'
require_relative 'usecase/assign_task_to_employee.rb'
require_relative 'usecase/mark_task_complete.rb'
require_relative 'usecase/list_employees.rb'
require_relative 'usecase/create_employee.rb'
require_relative 'usecase/show_employee_projects.rb'
require_relative 'usecase/show_remaining_employee_tasks.rb'
require_relative 'usecase/show_completed_employee_tasks.rb'
require 'pry-debugger'



