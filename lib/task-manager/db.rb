module TM
  class DB
    attr_reader :tasks, :projects
    def initialize
      @tasks = {}
      @projects = {}
      @project_count = 0
      @tasks_count = 0
    end

    def create_project(data)
      data[:id] = @project_count
      @project_count += 1
      @projects[data[:id]] = data
      build_project(data)
    end

    def get_project(id)
      data = @projects[id]
      if !data.nil?
        build_project(data)
      end
    end

    def build_project(data)
      Project.new(data[:name], data[:id])
    end

    # Inside a Command
    # task.mark_complete
    # db.update_task_b(task)

    def create_task(data)
      t_id = @tasks_count
      @tasks_count += 1
      data[:id] = t_id
      data[:complete] ||= false
      data[:timestamp] ||= Time.now
      @tasks[data[:id]] = data
      build_task(data)
    end

    def build_task(data)
      TM::Task.new(data[:project_id],
        data[:description],
        data[:priority],
        data[:id],
        data[:complete],
        data[:timestamp]
        )
    end

    def get_task(id)
      data = @tasks[id]
      if !data.nil?
        build_task(data)
      end
    end


  end

  def self.db
    @__db_instance ||= DB.new
  end
end