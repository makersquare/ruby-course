module TM

  # Our singleton getter
  def self.db
    @__db_instance ||= Database.new
  end

  # Our singleton class
  class Database
    attr_accessor :projects, :tasks

    def initialize
      @projects = {
        # name => proj obj
      }

      @tasks = {
        # id => task obj
      }
    end

    def add_project(name)
      newproject = TM::Project.new(name)
      @projects[name] = newproject
    end

    def add_task(task)
      task.project_id = @id
      @tasks[task.id] = task
    end

    def add_new_task(description, project_id, priority)
      project_id = project_id.to_i
      priority = priority.to_i
      proj = @projects.select{ |k,v| v.id == project_id}
      proj.add_task(TM::Task.new(description, project_id, priority))
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

end
