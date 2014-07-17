
class TM::Project
  attr_reader :project_id, :project_name

  @@id_counter = 0
  @@projects_list = []

  def initialize(project_name)
    @project_name = project_name
    @@id_counter += 1
    @project_id = @@id_counter
    @@projects_list << self
  end

  # returns a list of completed tasks
  def get_completed_tasks
    completed_tasks = TM::Task.task_list.select do |task|
      task.task_complete_status == true && task.project_id == @project_id
    end
    completed_tasks.sort_by {|task| task.task_creation_date}
  end
  # returns a list of incomplete tasks
  def get_incompleted_tasks
    incompleted_tasks = TM::Task.task_list.select do |task|
      task.task_complete_status == false && task.project_id == @project_id
    end
    # for each task we are sorting by the number first and the date second, this is done with <=> (combined comparison operator)
    incompleted_tasks.sort_by do |task|
      task.priority_number <=> task.task_creation_date
    end
  end

  def self.reset_class_variables
    @@id_counter = 0
    @@projects_list
  end

end
