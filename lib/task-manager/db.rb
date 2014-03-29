module TM
  class DB

    def initialize
      @all_projects = {}
      @all_tasks = {}
    end



    def create_project(name)
      project = Project.new(name)
      @all_projects[project.id] = project
      return project
    end

    def get_project(project_id)
      return @all_projects[project_id]
    end

    def create_task(data)
      task = Task.new(data)
      @all_tasks[task.id] = task
      return task
    end

    def get_task(task_id)
      return @all_tasks[task_id]
    end

    def completed_tasks(project_id)
      completed_tasks = @all_tasks.select { |k,v| (v.project_id == project_id) &&
                                                  (v.finished? == true)    }.values
      return completed_tasks.sort { |a,b| a.creation_date <=> b.creation_date }
    end

    def ongoing_tasks(project_id)
      ongoing_tasks = @all_tasks.select { |k,v| (v.project_id == project_id) &&
                                                 (v.finished? == false) }.values
      return ongoing_tasks.sort { |a,b| b.priority <=> a.priority }
    end

  end



  def self.db
    @__db_instance ||= DB.new
  end
end
