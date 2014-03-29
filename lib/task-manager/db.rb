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

    # Project use case methods

    def get_project_tasks(project_id)
      @tasks.select { |task_id, task| task.project_id == project_id }.values
    end

    def get_employees_on_project(project_id)
      @join_employees_projects.select do |hash|
        hash[:project_id] == project_id
      end.map do |hash|
        get_employee(hash[:employee_id])
      end
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

    # Task Use case methods

    def mark_task_complete(task_id)
      @tasks[task_id].complete = true
    end

    def complete_task_list(project_id)
      completedarray = get_project_tasks(project_id).select { |task| task.complete }
      completedarray.sort_by! { |task| task.timecreated }
    end

    def incomplete_task_list(project_id)
      incompletedarray = get_project_tasks(project_id).select { |task| !task.complete }
      incompletedarray.sort_by! { |task| [task.priority, task.timecreated] }
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

    # Employee use case methods

    def add_employee_to_project(employee_id, project_id)
      @join_employees_projects.push({employee_id: employee_id, project_id: project_id})
    end

    def assign_task_to_employee(employee_id, task_id)
      tasks[task_id].employee_id = employee_id
    end
  end

  def self.db
    @db ||= DB.new
  end
end
