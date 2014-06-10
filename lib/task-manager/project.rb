
class TM::Project
  attr_reader :id, :name, :task_list

  @@project_list = []

  def initialize(name)
    @name = name
    @@project_list << self
    @id = @@project_list.count
    @task_list = []
  end

  def self.project_list
    @@project_list
  end

  def self.project_list=(value)
    @@project_list = value
  end

  def add_task(description, priority_number)
    @task_list << TM::Task.new(description, priority_number, @id, @task_list.count)
  end

  def mark_complete(task_id)
    if @task_list[task_id].status == true
      return nil
    else
      @task_list[task_id].change_status
    end
  end

  def retrieve_completed_tasks
    completed_tasks = []
    @task_list.each do |task|
      completed_tasks << task if task.status == true
    end
    return completed_tasks
  end

end
