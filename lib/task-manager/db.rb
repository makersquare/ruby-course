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
    @project_task_participation = []

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
    # if ids were passed, make them the objects
    if task.is_a?(Fixnum) then task = TM::DB.instance.all_tasks[task] end
    if employee.is_a?(Fixnum) then employee = TM::DB.instance.all_employees[employee] end
    if TM::DB.instance.project_assigned?(task.project_id, employee)
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
    if task.is_a?(Fixnum) then task = TM::DB.instance.all_tasks[task] end
    if employee.is_a?(Fixnum) then employee = TM::DB.instance.all_employees[employee] end

    includes_employee = @task_assignments.select { |x| (x[:employee_id] == employee.employee_id) }
    includes_employee.each { |x| if x[:task_id] == task.task_id then return true end }

    return false
  end

  def employee_tasks(employee)
    if employee.is_a?(Fixnum) then task = TM::DB.instance.all_employees[employee] end

    employee_tasks = @task_assignments.select { |x| x[:employee] == employee }
    return employee_tasks.map { |x| x[:task] }
  end

  def ongoing_tasks(employee)
    tasks = TM::DB.instance.employee_tasks(employee)
    tasks = tasks.select { |x| x.finished? == false }
    tasks.sort! { |a,b| (a.priority <=> b.priority) == 0 ? (a.creation_date <=> b.creation_date) : (b.priority <=> a.priority) }
    return tasks
  end

  def completed_tasks(employee)
    tasks = TM::DB.instance.employee_tasks(employee)
    tasks.select! { |x| x.finished? == true }
    return tasks.sort { |a,b| a.creation_date <=> b.creation_date }
  end

  def project_employees(project)
    if project.is_a?(Fixnum) then project = TM::DB.instance.all_projects[project] end
    employees = project_assignments.select { |x| x[:project] == project }
    return employees.map { |x| x[:employee] }
  end

  def employee_projects(employee)
    if employee.is_a?(Fixnum) then task = TM::DB.instance.all_employees[employee] end

    employee_projects = @project_assignments.select { |x| x[:employee] == employee }
   return employee_projects.map { |x| x[:project] }
  end

end
