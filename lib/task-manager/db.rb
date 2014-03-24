class TM::DB
  attr_reader :projects, :employees

  def initialize
    @projects = {}
    @tasks = {}
    @employees = {}
    @join_projects_tasks = []
    @join_projects_employees = []
    @join_tasks_employees = []
  end

  def addproject(name)
    project = TM::Project.new(name)
    @projects[project.project_id] = project
  end

  def addemployee(name)
    employee = TM::Employee.new(name)
    @employees[employee.employee_id] = employee
  end

  def addtask()

  end


end
