
class TM::Project
  attr_reader :name, :project_id
  @@counter = 0
  @@projects_list = []

  def initialize name
    @name = name
    @project_id = @@counter
    @@counter += 1
    @@projects_list << self
  end

  def retrieve_incomplete_tasks
    incomplete = TM::Task.tasks_list.select do |task|
      task.project_id == self.project_id && task.status == :incomplete
    end
    incomplete.sort_by { |task| [task.priority, task.creation_time] }
  end

  def retrieve_completed_tasks
    complete = TM::Task.tasks_list.select do |task|
      task.project_id == self.project_id && task.status == :complete
    end
    complete.sort_by { |task| task.creation_time }
  end

  def self.projects_list
    @@projects_list
  end

end
