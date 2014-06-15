
class TM::Project
  attr_reader :id, :name, :task_list

  @@project_list = []

  def initialize(name)
    @name = name
    @id = @@project_list.count
    @@project_list << self
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

  def get_completed_tasks
    completed_tasks = @task_list.select { |task| task.status == true }
    completed_tasks.sort_by! { |task| task.creation_date }
  end

  def get_incomplete_tasks
    incomplete_tasks = @task_list.select { |task| task.status == false }
    # incomplete_tasks.sort_by! { |a, b| (a.priority_number <=> b.priority_number) == 0 ? (a.creation_date <=> b.creation_date) : (a.priority_number <=> b.priority_number) }
    incomplete_tasks.sort_by! { |a| [-a.priority_number, a.creation_date] }
  end

end
