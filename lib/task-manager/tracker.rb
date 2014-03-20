class TM::ProjectTracker
  attr_accessor :projects, :tasks, :employees

  def initialize
    @projects = []
    @tasks = []
    @employees = []
  end

  def create_new_project(name)
    project = TM::Project.new(name)
    @projects.push(project)
    return project
  end

  def show_tasks(project_id)
    if @tasks == [] || @projects == []
      return nil
    else
    project = @projects.find{|x| x.id == project_id.to_i}
    end
  end
  def add_task(project_id, description, priority_number)
     if @projects == []
    else
   project = @projects.find{|x| x.id == project_id.to_i}
   task = project.create_new_task(description, priority_number.to_i)
   @tasks.push(task)
    task
  end
end

   def complete_task(task_id)
    if @tasks == [] || @projects == []
      return nil
    else
      task = @tasks.find{|x| x.id == task_id.to_i}
      task.status = "complete"
      return task
   end
  end
  def add_new_employee(name)
    employee = TM::Employee.new(name)
    @employees.push(employee)
    employee
  end

  def assign_task(task_id, employee_id)
    task = @tasks.find {|x| x.id == task_id.to_i}
    employee = @employees.find {|x| x.id == employee_id.to_i}
    if task == nil || employee == nil
      return nil
    else
    task.employee = employee
    employee.tasks.push(task)
    task
    end
  end

  def assign_to_project(project_id, employee_id)
    if (@projects.find {|x| project_id.to_i == x.id}) == nil || (@employees.find {|x| employee_id.to_i == x.id}) == nil
      nil
    else
      project = @projects.find {|x| project_id.to_i == x.id}
      employee = @employees.find {|x| employee_id.to_i == x.id}
      project.employees.push(employee)
      employee.projects.push(project)
      employee
    end
  end
  def get_project(id)
    project = @projects.find {|x| id.to_i == x.id}
    project
  end

  def projects_of_employee(employee_id)
    employee = @employees.find {|x| x.id == employee_id.to_i}
    if employee == nil || employee.projects == []
      return nil
    else
      return employee.projects
    end
  end
  def remaining_employee_tasks(employee_id)
      employee = @employees.find {|x| x.id == employee_id.to_i}
      incomplete_tasks = employee.tasks.select{|x| x.status == "incomplete"}
      return incomplete_tasks
  end
  def completed_employee_tasks(employee_id)
      employee = @employees.find {|x| x.id == employee_id.to_i}
      complete_tasks = employee.tasks.select{|x| x.status == "complete"}
      return complete_tasks
  end
end









