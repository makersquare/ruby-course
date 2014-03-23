class TM::ProjectList
  attr_reader :projects, :employees

  def initialize
    @projects = {}
    @employees = {}
  end

  def addproject(name)
    project = TM::Project.new(name)
    @projects[project.project_id] = project
  end

  def addemployee(name)
    employee = TM::Employee.new(name)
    @employees[employee.employee_id] = employee
  end
end
