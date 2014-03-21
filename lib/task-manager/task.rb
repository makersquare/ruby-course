class TM::Task
  attr_accessor :project_id, :description, :priority, :finished
  attr_reader :task_id, :creation_date
  @@current_id = 1

  # -- ALLOWS RESETTING BY THE TESTER
  def self.current_id=(current_id)
    @@current_id = current_id
  end

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @task_id = @@current_id
    @@current_id = @@current_id + 1
    TM::DB.instance.all_tasks[@task_id] = self
    TM::DB.instance.all_projects[project_id].tasks[@task_id] = self
    @finished = false
    @creation_date = Time.now
  end

  def finished=(done)
    @finished = done
  end

  def finished?
    return finished
  end

end
