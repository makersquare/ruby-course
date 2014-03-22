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

  def assign_project(project, employee)
    # if an id was passed, make it the object
    if project.is_a?(Fixnum) then project = TM::DB.instance.all_projects[project] end
    if employee.is_a?(Fixnum) then employee = TM::DB.instance.all_employees[employee] end

    TM::DB.instance.project_assignments << { employee_id: employee.employee_id,
                                              project_id: project.id,
                                              employee: employee,
                                              project: project }
  end

  def assign_task(task, employee)
    if self.project_assigned?(task.project_id, employee)
      TM::DB.instance.task_assignments << { employee_id: employee.employee_id,
                                            task_id: task.task_id,
                                            employee: employee,
                                            task: task }
    else
      return false
    end
  end

  def task_assigned?(task, employee)
    # if ids were passed, make them the objects
    if task.is_a?(Fixnum) then task = TM::DB.instance.all_projects[task] end
    if employee.is_a?(Fixnum) then employee = TM::DB.instance.all_employees[employee] end

    includes_employee = @task_assignments.select { |x| (x[:employee_id] == employee.employee_id) }
    includes_employee.each { |x| if x[:task_id] == task.task_id then return true end }

    return false
  end

end
