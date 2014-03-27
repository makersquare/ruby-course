class TM::Project
attr_reader :name, :id
attr_accessor :tasks

  @@project_counter = 0

  def initialize(name)
    @name = name
    @@project_counter += 1
    @id = @@project_counter
    @tasks = {}
  end

  def add_task(task)
    task.project_id = @id
    @tasks[task.id] = task
  end

  def task_completed(task_id)
    task = @tasks.values.find { |task| task.id == task_id }
    task.status = true
    task
  end

  def retrieve_completed
    tasks_complete = @tasks.values.select { |task| task.status == true }
    tasks_complete.sort_by!{|task| task.id}
  end

  def retrieve_incomplete
    tasks_incomplete = @tasks.values.select { |task| task.status == false }
    tasks_incomplete.sort_by! {|task| [task.priority_number, task.id]}
  end

end
