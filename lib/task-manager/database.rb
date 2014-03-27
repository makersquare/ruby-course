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
        # id => proj obj
      }

      @tasks = {
        # id => task obj
      }

      @employees = {
        #id => emp obj
      }
    end

    def create_project(name)
      newproject = TM::Project.new(name)
      @projects[newproject.id] = newproject
    end

    def add_project_task(description, project_id, priority)
      project_id = project_id.to_i
      priority = priority.to_i
      task = TM::Task.new(description, project_id, priority)
      @tasks[task.id] = task
      task
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
