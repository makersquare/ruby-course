
class TM::Project
  attr_reader :name, :pid, :project_tasks

  @@project_index = 0
  @@master_project_list = {}

  def initialize(name)
    @name = name
    @pid = @@project_index
      @@project_index += 1
    @project_tasks = []
    @@master_project_list[@pid] = self
  end

  def self.get_project(pid)
    @@master_project_list[pid]
  end

  def self.get_projects
    @@master_project_list.values
  end

  def self.destroy_all_projects(bool)
    if bool
      @@project_index = 0
      @@master_project_list = {}
    end
  end

  def add_task(desc, priority)
    new_task = TM::Task.new(@pid, desc, priority)
    @project_tasks << new_task
  end

  def completed_tasks
    completed = @project_tasks.select {|tsk| tsk.complete}
    completed.sort {|a, b| a.creation_time <=> b.creation_time}
  end

  def incomplete_tasks
    incomplete = @project_tasks.select {|tsk| !tsk.complete}
    incomplete.sort {|a,b| (b.priority <=> a.priority) == 0 ? (a.creation_time <=> b.creation_time) : (b.priority <=> a.priority)}
  end
end
