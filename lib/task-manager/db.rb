module TM
  class DB
    attr_reader :projects, :employees, :tasks, :join_employees_projects

    def initialize
      @projects = {}
      @tasks = {}
      @employees = {}
      @join_employees_projects = []
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

    def get_all_projects()
      @projects.values
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

    def get_all_tasks()
      @tasks.values
    end

    def update_task()

    end

    def delete_task()

    end

    # Employee CRUD methods

    def create_employee(name)
      employee = TM::Employee.new(name)
      @employees[employee.employee_id] = employee
    end

    def get_employee(employee_id)
      @employees[employee_id]
    end

    def get_all_employees()
      @employees.values
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
