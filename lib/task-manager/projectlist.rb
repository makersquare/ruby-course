class TM::ProjectList
  attr_reader :projects

  def initialize
    @projects = []
    @employees = []
  end

  def addproject(name)
    project = TM::Project.new(name)
    @projects[project.id] = project
  end

  def addemployee(name)
    employee = TM::Employee.new(name)
    @employees[employee.id] = employee
  end
end
