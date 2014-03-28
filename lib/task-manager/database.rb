class TM::Database
  attr_accessor :projects, :tasks, :employees, :membership

# Initialize Database Method #

  def initialize
    @projects = {}
    @tasks = {}
    @employees = {}
    @membership = []
  end

# Create Methods #

  def create_new_project(name)
    project = TM::Project.new(name)
    @projects[project.id] = project
    project
  end

  def add_new_employee(name)
    employee = TM::Employee.new(name)
    @employees[employee.id] = employee
    employee
  end

  def add_task(project_id, priority_number, description)
    project = @projects[project_id]
    task = TM::Task.new(project_id.to_i, priority_number.to_i, description)
    @tasks[task.id] = task
    return task
  end

# Read Methods #

  def get_project(id)
    project = @projects[id]
    project
  end

  def get_all_projects
      @projects
  end

  def get_employee(id)
    employee = @employees[id]
    employee
  end

  def get_task(id)
    task = @tasks[id]
    task
  end
  def delegate_employee_to_project(employee_id, project_id)
    @membership.push({:employee_id => employee_id, :project_id => project_id})
  end
end

# Update Methods

# Destroy Methods




