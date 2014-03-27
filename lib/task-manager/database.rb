module TM
  class Database
    def initialize
      @projects = {}
      @tasks = {}
    end

    def create_project(name)
      project = Project.new(name)
      @projects[project.id] = project
      project
    end

    def all_projects
      @projects.values
    end

    def add_task_to_proj(pid, task_name, priority)
      task = Task.new(pid, task_name, priority)
      @tasks[task.id] = task
      task
    end

    def get_task(tid)
      @tasks[tid]
    end

    def show_proj_tasks_remaining(pid)
      @tasks.values.select {|task|
        task.proj_id == pid
      }.sort_by {|task| task.priority }
    end
  end
end
