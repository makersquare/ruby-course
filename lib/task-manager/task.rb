class TM::Task
  attr_accessor :project_id, :description, :priority, :finished
  attr_reader :task_id
  @@current_id = 1
  @@all_tasks = {}

  # -- ALLOWS RESETTING BY THE TESTER
  def self.current_id=(current_id)
    @@current_id = current_id
  end

  ## -- ALLOWS RESETTING BY THE TESTER
  def self.all_tasks=(all_tasks)
    @@all_tasks = all_tasks
  end

  def self.all_tasks
    return all_tasks
  end


  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @task_id = @@current_id
    @@current_id = @@current_id + 1
    @@all_tasks[@task_id] = self
    @finished = false
  end



end
