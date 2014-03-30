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

  def get_all_employees
      @employees
  end

  def get_employee(id)
    employee = @employees[id]
    employee
  end

  def get_task(id)
    task = @tasks[id]
    task
  end

  def get_project_history(project_id)
      @tasks.values.select{|x| (x.project_id == project_id) && (x.status == "complete")}
  end

  def get_project_remaining(project_id)
      @tasks.values.select{|x| (x.project_id == project_id) && (x.status == "incomplete")}
  end

  def get_employee_history(employee_id)
    @tasks.values.select{|x| (x.employee_id == employee_id) && (x.status == "complete")}
  end

  def get_employee_remaining(employee_id)
    @tasks.values.select{|x| (x.employee_id == employeed_id) && (x.status == "incomplete")}
  end
# Update Methods
  def delegate_employee_to_project(employee_id, project_id)
    @membership.push({:employee_number => employee_id.to_i, :project_number => project_id.to_i})
  end
  def mark_task_as_complete(task)
    task.status = "complete"
  end
  # Destroy Methods
end







