
# Create our module. This is so other files can start using it immediately
module TM
  class DB
    attr_reader :projects, :employees

    def initialize
      @projects = {}
      @tasks = {}
      @employees = {}
      @join_projects_employees = []
    end

    def create_project(name)
      project = TM::Project.new(name)
      @projects[project.project_id] = project
    end

    def get_project(project_id)
      @projects[project_id]
    end

    def update_project()

    end

    def delete_project()

    end

    def create_task()
      #task needs to be associated wiht a project
    end

    def get_task(task_id)
      @tasks[task_id]
    end

    def update_task()

    end

    def delete_task()

    end

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
