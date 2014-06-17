class TM::Project
  attr_reader :name, :id, :project_id, :projects, :task_id
  attr_accessor :task_list
  @@project_id = 0
  @@projects = []

  def self.project_id
    @@project_id
  end

  def self.projects
    @@projects
  end

  def initialize(name)
    @name = name
    @id = @@project_id
    @task_list = Hash.new
    @task_count = 0
    @@project_id += 1
    @@projects << self
    @task_id
  end

  def add_task(description, priority)
    @task_id = "#{@id}.#{@task_count}"
    @task_list[@task_id] = TM::Task.new(description, priority, @task_id)
    @task_count += 1
  end

  def complete(tid)
    @task_list[tid].complete
  end

  def list_complete
    @task_list.select { |k, v| v.status == 'complete' }.sort_by { |k, v| v.time_created }
  end

  def list_tasks
    @task_list.select { |k, v| v.status == 'not complete' }.sort_by { |k, v| v.time_created }.reverse
  end
end


