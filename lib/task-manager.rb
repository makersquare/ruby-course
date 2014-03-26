
# Create our module. This is so other files can start using it immediately
module TM
  class DB
    attr_reader :projects, :employees, :tasks

    def initialize
      @projects = {}
      @tasks = {}
      @employees = {}
      @join_projects_employees = []
    end

    # Project CRUD methods

    def create_project(name)
      project = TM::Project.new(name)
      @projects[project.project_id] = project
      project
    end

    def get_project(project_id)
      @projects[project_id]
    end

    def update_project()

    end

    def delete_project()

    end

    # Task CRUD methods

    def create_task(description, priority, project_id)
      new_task = TM::Task.new(description, priority, project_id)
      @tasks[new_task.task_id] = new_task
      new_task
    end

    def get_task(task_id)
      @tasks[task_id]
    end

    def update_task()

    end

    def delete_task()

    end

    # Task User case methods

    def mark_task_complete(task_id)
      @tasks[task_id].complete = true
    end

    # Employee CRUD methods

    def create_employee(name)
      employee = TM::Employee.new(name)
      @employees[employee.employee_id] = employee
    end

    def get_employee(employee_id)
      @employees[employee_id]
    end

    def update_employee()

    end

    def delete_employee()

    end
  end

  def self.db
    @db ||= DB.new
  end
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/pm.rb'
require_relative 'task-manager/db.rb'
require_relative 'task-manager/employee.rb'
