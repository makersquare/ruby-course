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

  def add_project(project)
    # adjust for type of input
    if project.is_a?(TM::Project)
      project_object = project
    else
      project_object = TM::DB.instance.all_projects[project]
    end

    # add it to the projects hash
    @projects[project_object.id] = project_object
  end

  def add_task(task)
    # adjust for type of input
    if task.is_a?(TM::Task)
      task_object = task
    else
      task_object = TM::DB.instance.all_tasks[task]
    end

    # if the employee belongs to the project
    if @projects.has_key?(task_object.project_id)
      tasks[task_object.task_id] = task_object
    else
      return false
    end

  end

  def ongoing_tasks  #returns ongoing_tasks in the proper order
    ongoing_tasks = @tasks.select { |k,v| v.finished? == false }.values
    ongoing_tasks.sort! { |a,b| (a.priority <=> b.priority) == 0 ? (a.creation_date <=> b.creation_date) : (b.priority <=> a.priority) }
    return ongoing_tasks
  end


end

