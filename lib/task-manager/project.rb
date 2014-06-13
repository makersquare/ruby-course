class TM::Project
  attr_reader :name, :id, :tasks

  def initialize(name)
    @name = name
    @tasks = []
  end

  def create_task(desc, key)
    @tasks << TM::Task.new(desc, key)
  end

  def mark_complete(id)
    @tasks[id].complete
  end

  def sort_complete
    # @tasks.select { |t| t.done }.sort_by {|task| task.date }
    sorted_tasks = @tasks.sort_by {|task| task.date}
    completed_tasks = []
    sorted_tasks.each do |task|
      if task.done
        completed_tasks << task
      end
    end
    completed_tasks
  end

  def sort_priority
    sorted_tasks = @tasks.sort_by {|task| task.key}
    important_tasks = []
    sorted_tasks.each do |task|
      if !task.done
        important_tasks << task
      end
    end
    important_tasks
  end

  def show_tasks
    list = sort_priority.reverse! #reverses to print in order of most important
    i = 0
    list.each do |task|
      puts task.desc
      i += 1
    end
  end

  def show_done
    list = sort_complete
    list.each do |task|
      puts task.desc
    end
  end
  def finish(tid)
    @tasks[tid].complete
  end
end
