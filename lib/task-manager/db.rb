require 'singleton'

class TM::DB

  include Singleton
  attr_reader :all_employees, :all_projects, :all_tasks, :task_assignments
  attr_reader :project_assignments
  def initialize
    @all_employees = {}
    @all_projects = {}
    @all_tasks = {}
    @task_assignments = []
    @project_assignments = []
  end

  def project_assigned?(project, employee)
    # if an id was passed, make it the object
    if project.is_a?(Fixnum) then project = TM::DB.instance.all_projects[project] end
    if employee.is_a?(Fixnum) then employee = TM::DB.instance.all_employees[employee] end

    includes_employee = @project_assignments.select { |x| (x[:employee_id] == employee.employee_id) }
    includes_employee.each { |x| if x[:project_id] == project.id then return true end }

    return false
  end
end
