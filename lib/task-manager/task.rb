class TM::Task
  attr_accessor :project_id, :description, :priority, :finished
  attr_reader :task_id, :creation_date
  @@current_id = 1
  # @@all_tasks = {}                    # moving to DB

  # -- ALLOWS RESETTING BY THE TESTER
  def self.current_id=(current_id)
    @@current_id = current_id
  end

  # def self.all_tasks                     # moving to DB
  #   return @@all_tasks
  #end

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @task_id = @@current_id
    @@current_id = @@current_id + 1
    # @@all_tasks[@task_id] = self            # switching to database
    TM::DB.instance.all_tasks[@task_id] = self  #add itself to list of all tasks
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
