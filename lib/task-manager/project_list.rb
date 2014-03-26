class TM::ProjectList
  attr_reader :project_list

  def initialize
    @project_list = []
    @employees

  end

  def add_project(name)
    proj = TM::Project.new(name)
    @project_list << proj
    proj
  end


  def get_project(project_id)
    match = @project_list.select {|x| x.project_id == project_id}
    match[0]
  end

  def get_remaining_tasks(project_id)
    remaining_tasks = @project_list.select{|x| x.project_id == project_id}
    return match[0].incomlete_tasks
  end

  def get_completed(project_id)
    completed = @project_list.select{|x| x.project_id == project_id}
    return completed[0].completed_tasks
  end

  def add_tasks(project_id, description, priority=3)
    match = @project_list.find {|project| project.project_id == project_id}
    return match[0].add_task(description, priority=3)
  end

  def mark_complete(project_id, task_id)
    match = @project_list.find { |project| project.project_id == project_id }
    return match[0].complete_task(task_id)
  end

end

