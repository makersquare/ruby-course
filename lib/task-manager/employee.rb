class TM::Employee
  attr_reader :name, :employee_id, :projects, :tasks

  @@current_id = 1

  def initialize(name)
    @name = name
    @employee_id = @@current_id
    @@current_id = @@current_id + 1
    TM::DB.instance.all_employees[@employee_id] = self
    @projects = {}
    @tasks = {}

  end

  # def add_project(project)
  #   # if 'project' is the id, make it the object
  #   if project.is_a?(Fixnum) then (project = TM::DB.instance.all_projects[project]) end
  #   # add it to the projects hash
  #   @projects[project.id] = project
  #   TM::DB.instance.assign_employee(project, self)
  # end

  def add_task(task)
    # if 'task' is an id, make it the object
    if task.is_a?(Fixnum) then task = TM::DB.instance.all_tasks[task] end

    # if the employee belongs to the project
    # if @projects.has_key?(task.project_id)
    if TM::DB.instance.project_assigned?(task.project_id, self)
      tasks[task.task_id] = task
    else
      return false
    end
  end

  def ongoing_tasks  #returns ongoing_tasks in the proper order
    ongoing_tasks = @tasks.select { |k,v| v.finished? == false }.values
    ongoing_tasks.sort! { |a,b| (a.priority <=> b.priority) == 0 ? (a.creation_date <=> b.creation_date) : (b.priority <=> a.priority) }
    return ongoing_tasks
  end

  def completed_tasks  #returns completed_tasks in the proper order
    completed_tasks = @tasks.select { |k,v| v.finished? == true }.values
    return completed_tasks.sort { |a,b| a.creation_date <=> b.creation_date }
  end



end

