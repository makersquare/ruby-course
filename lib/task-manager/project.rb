
class TM::Project
  # @@projects = 0
  @@counter = 1
  attr_accessor :name
  attr_reader :id, :tasks
  def initialize(name)
    @name = name
    @id = @@counter
    @@counter += 1
    @tasks = []

  end

  #helper method for tests
  def self.reset_class_variables
    @@counter = 1
  end

  def add_task(task)
    @tasks << task
  end

  def mark_complete(task_id)
    @tasks.each do |task|
      if task.task_id == task_id
        task.status = "Completed"
      end
    end
  end

  def completed_tasks
    new_array = @tasks.select { |task| task.status == "Completed" }

    new_array.sort! {|a, b| a.creation_date <=> b.creation_date}
  end

  def incomplete_tasks
    new_array = @tasks.select{ |task| task.status == "Not completed"}
    new_array.sort! {|a,b| a.priority <=> b.priority}
  end

end
