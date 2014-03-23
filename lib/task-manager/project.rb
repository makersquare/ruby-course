class TM::Project
  attr_reader :name, :id, :tasks, :assigned_employees

  @@current_id = 1

  # for testing
  def self.current_id=(current_id)
    @@current_id = current_id
  end

  def initialize(name)
    @name = name
    @id = @@current_id
    @@current_id = @@current_id + 1
    @tasks = {}
    @assigned_employees = {}
    TM::DB.instance.all_projects[@id] = self
  end

  def add_task(task)  # takes a task id or a Task object and adds the task to the project hash
    # set task object depending on what has been passed
    if task.is_a?(TM::Task)     #if an object was passed
      task_object = task
    else     # if a task_id was passed
      task_object = TM::DB.instance.all_tasks[task]
    end

    # add the task to the @tasks hash
    @tasks[task_object.task_id] = task_object
  end

  def mark_as_finished(task_id)
    @tasks[task_id].finished = true
  end

  def completed_tasks  #returns completed_tasks in the proper order
    completed_tasks = @tasks.select { |k,v| v.finished? == true }.values
    return completed_tasks.sort { |a,b| a.creation_date <=> b.creation_date }
  end

  def ongoing_tasks  #returns ongoing_tasks in the proper order
    ongoing_tasks = @tasks.select { |k,v| v.finished? == false }.values
    ongoing_tasks.sort! { |a,b| (a.priority == b.priority) ? (a.creation_date <=> b.creation_date) : (b.priority <=> a.priority) }
    return ongoing_tasks
  end

  def assign_employee(employee)
    # detect whether an id or an Employee was passed and adjust for it
    if employee.is_a?(TM::Employee)
      employee_object = employee
    else
      employee_object = TM::DB.instance.all_employees[employee]
    end

    @assigned_employees[employee_object.employee_id] = employee_object
  end


end
